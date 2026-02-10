import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../../config/app_config.dart';
import '../../connectivity/connectivity_manager_controller.dart';
import '../../constants/app_constants.dart';
import '../../helper/app_helper.dart';
import '../../helper/app_widgets.dart';
import '../../helper/print_log.dart';
import '../../helper/shared_value_helper.dart';

class ApiClient {
  Dio? dio;

  final _connectionController = Get.find<ConnectionManagerController>().obs;
  final String _accessToken = accessToken.$;

  static const String _noInternetMessage = "No Internet Connection";
  static const String _infoTitle = "Info";

  /// Show no internet connection error
  void _showNoInternetError() {
    AppHelper().hideLoader();
    AppWidgets().getSnackBar(title: _infoTitle, message: _noInternetMessage);
  }

  /// Check if response is HTML (server error page)
  bool _isHtmlResponse(dynamic response) {
    if (response == null) return false;
    final responseString = response.toString();
    return responseString.contains('<!DOCTYPE html>') ||
        responseString.contains('<html') ||
        responseString.contains('<!doctype html>');
  }

  /// Extract error message from response
  String? _extractErrorMessage(Response? response) {
    if (response == null) return null;
    try {
      final responseString = response.toString();
      if (responseString.isEmpty || responseString == 'null') return null;

      // Check if it's an HTML response (server error page)
      if (_isHtmlResponse(responseString)) {
        return "Server error. Please try again later.";
      }

      final decoded = jsonDecode(responseString);
      if (decoded == null) return null;

      if (decoded is Map) {
        final message = decoded["message"];
        if (message == null) return null;

        if (message is List && message.isNotEmpty) {
          return message[0]?.toString();
        } else if (message is String) {
          return message;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  ApiClient({customBaseUrl = ''}) {
    final options = BaseOptions(
      baseUrl: customBaseUrl.isNotEmpty ? customBaseUrl : AppConfig.basePath,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain,
    );
    dio = Dio(options);

    (dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        };

    dio!.interceptors.add(_createInterceptor());
  }

  /// Create the main interceptor for handling requests, responses, and errors
  QueuedInterceptorsWrapper _createInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final networkConnected =
            _connectionController.value.isInternetConnected.value;

        if (kDebugMode) {
          logger.i(
            'Network Status: ${networkConnected ? 'CONNECTED' : 'DISCONNECTED'} | URL: ${options.uri}',
          );
        }

        if (!networkConnected) {
          _showNoInternetError();
          return handler.reject(
            DioException(
              requestOptions: options,
              error: _noInternetMessage,
              type: DioExceptionType.connectionError,
            ),
          );
        }

        return handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (err, handler) => _handleError(err, handler),
    );
  }

  /// Handle errors in the interceptor
  Future<void> _handleError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // Handle connection errors
      if (_isConnectionError(err.type)) {
        _showNoInternetError();
        return handler.reject(err);
      }

      final statusCode = err.response?.statusCode;
      if (statusCode == null) {
        return handler.reject(err);
      }

      final response = err.response;
      if (response == null) {
        return handler.reject(err);
      }

      // Check if response is HTML (server error page)
      if (_isHtmlResponse(response)) {
        final retryCount = err.requestOptions.extra['retry_count'] as int? ?? 0;

        if (retryCount < 5) {
          printLog(
            'HTML response detected. Retrying... (Attempt ${retryCount + 1}/5)',
          );

          // Increment retry count
          err.requestOptions.extra['retry_count'] = retryCount + 1;

          // Wait before retrying (exponential backoff)
          await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));

          // Retry the request
          try {
            final retryResponse = await dio!.fetch(err.requestOptions);
            return handler.resolve(retryResponse);
          } catch (e) {
            // If retry fails, it will go through the interceptor again
            rethrow;
          }
        } else {
          // Max retries reached
          AppHelper().hideLoader();
          AppWidgets().getSnackBar(
            title: _infoTitle,
            message: "Server error. Please try again later.",
          );
          return handler.reject(err);
        }
      }

      switch (statusCode) {
        case 204:
          return handler.resolve(response);

        case 400:
          final message = _extractErrorMessage(response);
          // Don't show snackbar for "no data found" messages (common in list endpoints)
          if (message != null &&
              message.isNotEmpty &&
              !message.toLowerCase().contains('no data found') &&
              !message.toLowerCase().contains('no data')) {
            AppWidgets().getSnackBar(title: _infoTitle, message: message);
          }
          return handler.reject(err);

        case 401:
          dio?.options.headers["Authorization"] = _accessToken;
          return handler.resolve(response);

        case 500:
          AppHelper().hideLoader();
          final message = _extractErrorMessage(response);
          AppWidgets().getSnackBar(
            title: _infoTitle,
            message: message ?? "Server error (500). Please try again later.",
          );
          return handler.reject(err);

        case 502:
        case 503:
        case 504:
          AppHelper().hideLoader();
          final message = _extractErrorMessage(response);
          AppWidgets().getSnackBar(
            title: _infoTitle,
            message:
                message ?? "Server temporarily unavailable. Please try again.",
          );
          return handler.reject(err);

        default:
          final message = _extractErrorMessage(response);
          // Don't show snackbar for "no data found" messages (common in list endpoints)
          if (message != null &&
              message.isNotEmpty &&
              !message.toLowerCase().contains('no data found') &&
              !message.toLowerCase().contains('no data')) {
            AppWidgets().getSnackBar(title: _infoTitle, message: message);
          }
          return handler.resolve(response);
      }
    } catch (e) {
      printLog('Error in _handleError: $e');
      return handler.reject(err);
    }
  }

  /// Check if error is a connection-related error
  bool _isConnectionError(DioExceptionType type) {
    return type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout;
  }

  /// Configure headers for the request
  void _configureHeaders({
    required bool isHeaderRequired,
    Map<String, dynamic>? headers,
    String? languageCode,
  }) {
    dio?.options.headers["isApp"] = true;

    if (isHeaderRequired) {
      dio?.options.headers["Authorization"] = _accessToken;
      if (languageCode != null) {
        dio?.options.headers["language_code"] = languageCode;
      }
    }

    if (headers != null && headers.isNotEmpty) {
      headers.forEach((key, value) {
        dio?.options.headers[key] = value;
      });
    }
  }

  Future<Object?> get(
    String url,
    retry, {
    Map<String, dynamic>? mQueryParameters,
    Map<String, dynamic>? headers,
    bool isLoaderRequired = false,
    bool isHeaderRequired = false,
  }) async {
    if (isLoaderRequired) {
      AppHelper().showLoader();
    }

    try {
      _configureHeaders(
        isHeaderRequired: isHeaderRequired,
        headers: headers,
        languageCode: "en",
      );

      final response = await dio?.get(url, queryParameters: mQueryParameters);

      if (kDebugMode) {
        logger.w(
          'GET URL: $url\nQueryParameters: $mQueryParameters\nResponse: $response',
        );
      }

      if (isLoaderRequired) {
        await Future.delayed(const Duration(seconds: 1));
        AppHelper().hideLoader();
      }

      return response;
    } on DioException catch (e) {
      AppHelper().hideLoader();

      // Check if response is HTML error page
      if (_isHtmlResponse(e.response)) {
        final retryCount = e.requestOptions.extra['retry_count'] as int? ?? 0;

        if (retryCount < 5) {
          printLog(
            'GET HTML response. Retrying... (${retryCount + 1}/5): $url',
          );
          e.requestOptions.extra['retry_count'] = retryCount + 1;
          await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));

          return await get(
            url,
            retry,
            mQueryParameters: mQueryParameters,
            headers: headers,
            isLoaderRequired: false, // Don't show loader on retry
            isHeaderRequired: isHeaderRequired,
          );
        }

        printLog('GET max retries reached for HTML response: $url');
        return null;
      }

      // Return response for non-header requests with valid JSON response
      if (!isHeaderRequired && e.response != null) {
        return e.response;
      }
      return null;
    }
  }

  /// Prepare form data for file uploads
  Future<FormData> _prepareFormData({
    required dynamic data,
    required bool isFormData,
    required bool isMultipleFileUpload,
  }) async {
    if (!isMultipleFileUpload) {
      return FormData.fromMap(isFormData ? data : {});
    }

    final formData = FormData();
    for (var file in data) {
      formData.files.addAll([
        MapEntry("images", await MultipartFile.fromFile(file.path)),
      ]);
    }
    return formData;
  }

  /// Prepare request data based on content type
  dynamic _prepareRequestData({
    required dynamic data,
    required bool isFormData,
    required bool isJsonEncodeRequired,
    required FormData formData,
  }) {
    if (isFormData) {
      return formData;
    }
    if (data == null) {
      return null;
    }
    return isJsonEncodeRequired ? jsonEncode(data) : data;
  }

  Future<Response?> post(
    String url,
    data,
    retry, {
    Map<String, dynamic>? headers,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
    bool isFileUpload = false,
    bool isMultipleFileUpload = false,
    bool isMultipart = false,
    bool isServiceCode = false,
    Map<String, dynamic>? mQueryParameters,
  }) async {
    if (isLoaderRequired) {
      AppHelper().showLoader();
    }

    try {
      if (isHeaderRequired) {
        if (isFileUpload || isMultipleFileUpload) {
          dio?.options.baseUrl = AppConfig.basePath;
        }
        dio?.options.headers["Authorization"] = _accessToken;
        dio?.options.headers["Content-Type"] = isMultipart
            ? "multipart/form-data"
            : "application/json";
        if (isServiceCode) {
          dio?.options.headers["service_code"] = "sl_customer";
        }
      }

      _configureHeaders(isHeaderRequired: false, headers: headers);

      final formData = await _prepareFormData(
        data: data,
        isFormData: isFormData,
        isMultipleFileUpload: isMultipleFileUpload,
      );

      final requestData = _prepareRequestData(
        data: data,
        isFormData: isFormData,
        isJsonEncodeRequired: isJsonEncodeRequired,
        formData: formData,
      );

      if (kDebugMode) {
        logger.i('POST URL: ${dio?.options.baseUrl}$url\nData: $data');
      }

      final response = await dio?.post(
        url,
        data: requestData,
        queryParameters: mQueryParameters,
      );

      if (kDebugMode) {
        logger.i('POST Response: $response');
      }

      AppHelper().hideLoader();
      return response;
    } on DioException catch (e) {
      AppHelper().hideLoader();

      // Check if response is HTML error page
      if (_isHtmlResponse(e.response)) {
        final retryCount = e.requestOptions.extra['retry_count'] as int? ?? 0;

        if (retryCount < 5) {
          printLog(
            'POST HTML response. Retrying... (${retryCount + 1}/5): $url',
          );
          e.requestOptions.extra['retry_count'] = retryCount + 1;
          await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));

          return await post(
            url,
            data,
            retry,
            headers: headers,
            isHeaderRequired: isHeaderRequired,
            isLoaderRequired: false, // Don't show loader on retry
            isFormData: isFormData,
            isJsonEncodeRequired: isJsonEncodeRequired,
            isFileUpload: isFileUpload,
            isMultipleFileUpload: isMultipleFileUpload,
            isMultipart: isMultipart,
            isServiceCode: isServiceCode,
            mQueryParameters: mQueryParameters,
          );
        }

        printLog('POST max retries reached for HTML response: $url');
        return null;
      }

      // Return response for specific status codes that need handling
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 403) {
        return e.response;
      }

      // Return response for non-header requests with valid response
      if (!isHeaderRequired && e.response != null) {
        return e.response;
      }
      return null;
    }
  }

  Future<Object?> put(
    String url,
    data,
    retry, {
    Map<String, dynamic>? headers,
    bool isHeaderRequired = true,
    bool isLoaderRequired = false,
    Map<String, dynamic>? mQueryParameters,
  }) async {
    if (isLoaderRequired) {
      AppHelper().showLoader();
    }

    try {
      if (isHeaderRequired) {
        dio?.options.headers["Authorization"] = _accessToken;
        dio?.options.headers["Content-Type"] = "application/json";
      }

      _configureHeaders(isHeaderRequired: false, headers: headers);

      final response = await dio?.put(
        url,
        data: data,
        queryParameters: mQueryParameters,
      );

      if (kDebugMode) {
        logger.i('PUT URL: $url\nData: $data\nResponse: $response');
      }

      AppHelper().hideLoader();
      return response;
    } on DioException catch (e) {
      AppHelper().hideLoader();

      // Check if response is HTML error page
      if (_isHtmlResponse(e.response)) {
        final retryCount = e.requestOptions.extra['retry_count'] as int? ?? 0;

        if (retryCount < 5) {
          printLog(
            'PUT HTML response. Retrying... (${retryCount + 1}/5): $url',
          );
          e.requestOptions.extra['retry_count'] = retryCount + 1;
          await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));

          return await put(
            url,
            data,
            retry,
            headers: headers,
            isHeaderRequired: isHeaderRequired,
            isLoaderRequired: false, // Don't show loader on retry
            mQueryParameters: mQueryParameters,
          );
        }

        printLog('PUT max retries reached for HTML response: $url');
        return null;
      }

      // Return response for non-header requests with valid response
      if (!isHeaderRequired && e.response != null) {
        return e.response;
      }
      return null;
    }
  }

  Future<Response?> delete(
    String url,
    data,
    retry, {
    Map<String, dynamic>? mQueryParameters,
    Map<String, dynamic>? headers,
    bool isHeaderRequired = false,
    bool isLoaderRequired = false,
    bool isFormData = false,
    bool isJsonEncodeRequired = true,
  }) async {
    if (isLoaderRequired) {
      AppHelper().showLoader();
    }

    try {
      if (isHeaderRequired) {
        dio?.options.headers["Authorization"] = _accessToken;
        dio?.options.headers["Content-Type"] = "application/json";
      }

      _configureHeaders(isHeaderRequired: false, headers: headers);

      final response = await dio?.delete(
        url,
        data: data,
        queryParameters: mQueryParameters,
      );

      if (kDebugMode) {
        logger.w(
          'DELETE URL: $url\nQueryParameters: $mQueryParameters\nResponse: $response',
        );
      }

      AppHelper().hideLoader();
      return response;
    } on DioException catch (e) {
      AppHelper().hideLoader();

      // Check if response is HTML error page
      if (_isHtmlResponse(e.response)) {
        final retryCount = e.requestOptions.extra['retry_count'] as int? ?? 0;

        if (retryCount < 5) {
          printLog(
            'DELETE HTML response. Retrying... (${retryCount + 1}/5): $url',
          );
          e.requestOptions.extra['retry_count'] = retryCount + 1;
          await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));

          return await delete(
            url,
            data,
            retry,
            mQueryParameters: mQueryParameters,
            headers: headers,
            isHeaderRequired: isHeaderRequired,
            isLoaderRequired: false, // Don't show loader on retry
            isFormData: isFormData,
            isJsonEncodeRequired: isJsonEncodeRequired,
          );
        }

        printLog('DELETE max retries reached for HTML response: $url');
        return null;
      }

      // Return response for non-header requests with valid response
      if (!isHeaderRequired && e.response != null) {
        return e.response;
      }
      return null;
    }
  }

  /// Get dynamic API data (legacy method - consider using get() instead)
  Future<dynamic> getDynamicApiData(String url) async {
    try {
      final response = await Dio().get("${AppConfig.basePath}$url");
      return response;
    } catch (e) {
      if (kDebugMode) {
        logger.e('getDynamicApiData error: $e');
      }
      return null;
    }
  }
}
