import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../../config/app_config.dart';
import '../../connectivity/connectivity_manager_controller.dart';
import '../../constants/app_constants.dart';
import '../../helper/app_helper.dart';
import '../../helper/app_widgets.dart';
import '../../helper/print_log.dart';
import '../../helper/shared_value_helper.dart';

class ApiClient {
  Dio? dio;

  final _connectionController =
      getX.Get.find<ConnectionManagerController>().obs;

  final String _accessToken = accessToken.$;

  ApiClient({customBaseUrl = ''}) {
    BaseOptions options = BaseOptions(
      baseUrl: customBaseUrl != '' ? customBaseUrl : AppConfig.basePath,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 30),
      responseType:
          ResponseType
              .plain,
    );
    dio = Dio(options);
    dio!.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          printLog("On request working");
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          printLog("On response working");
          return handler.next(response);
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          if (err.response?.statusCode == 401) {
            AppHelper().logout();

            AppWidgets().getSnackBar(
              title: "Info",
              message: "Response error code: 401",
            );

            dio?.options.headers["Authorization"] = _accessToken;
            printLog("Refreshing token done");
            return handler.next(err);
          } else if (err.response?.statusCode == 400) {
            return handler.reject(err);
          } else if (err.response?.statusCode == 503) {
            AppWidgets().getSnackBar(
              title: "Info",
              message: jsonDecode(err.response!.toString())["message"][0],
            );
            return handler.resolve(err.response!);
          } else if (err.response?.statusCode == 500) {
            await Future.delayed(const Duration(seconds: 1));
            AppHelper().hideLoader();
            AppWidgets().getSnackBar(
              title: "Info",
              message: "Response error code: 500",
            );
            return handler.resolve(err.response!);
          } else if (err.response?.statusCode == 204) {
            await Future.delayed(const Duration(seconds: 1));
            AppHelper().hideLoader();
            AppWidgets().getSnackBar(
              title: "Info",
              message: "Response error code: 500",
            );
            return handler.resolve(err.response!);
          } else if (err.response?.statusCode == 401) {
            AppHelper().logout();

            AppWidgets().getSnackBar(
              title: "Info",
              message:
                  "Response error "
                  "code: 401",
            );
            return handler.resolve(err.response!);
          } else {
            if (err.response != null) {
              AppWidgets().getSnackBar(
                title: "Info",
                message: err.message ?? "An error occurred",
              );
              return handler.resolve(err.response!);
            } else {
              // No response - likely a connection error
              AppWidgets().getSnackBar(
                title: "Connection Error",
                message: err.message ?? "Unable to connect. Please check your internet connection.",
              );
              return handler.reject(err);
            }
          }
        },
      ),
    );
  }

  Future<Object?> get(
    String url,
    retry, {
    Map<String, dynamic>? mQueryParameters,
    bool isLoaderRequired = false,
    bool isHeaderRequired = false,
  }) async {
    if (_connectionController.value.isInternetConnected.isTrue) {
      dio?.options.headers["isApp"] = true;
      if (kDebugMode) {
        printLog(
          'URL:${AppConfig.basePath}$url\nQueryParameters: $mQueryParameters',
        );
      }
      if (isLoaderRequired) {
        AppHelper().showLoader();
      }
      try {
        if (isHeaderRequired) {
          dio?.options.headers["Authorization"] = _accessToken;
          dio?.options.headers["language_code"] =
              "en";
        }

        var response = await dio?.get(url, queryParameters: mQueryParameters);
        if (kDebugMode) {
          printLog(
            'URL:  $url\nQueryParameters: $mQueryParameters\nResponse: $response',
          );
        }

        if (isLoaderRequired) {
          await Future.delayed(const Duration(seconds: 1));
          AppHelper().hideLoader();
        }
        return response;
      } on DioException catch (e) {
        handelException(e);
        AppHelper().hideLoader();
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else {
          return null;
        }
      }
    }
    return null;
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
    if (_connectionController.value.isInternetConnected.isTrue) {
      if (isLoaderRequired) {
        AppHelper().showLoader();
      }
      /* AppHelper().showLoader();
    AppHelper().hideKeyboard();*/
      dio?.options.headers["isApp"] = true;

      try {
        if (isHeaderRequired) {
          // token = accessToken.$;
          if (isFileUpload || isMultipleFileUpload) {
            dio?.options.baseUrl = AppConfig.imageBasePath;
          }
          dio?.options.headers["Authorization"] = _accessToken;
          dio?.options.headers["Content-Type"] =
              !isMultipart ? "application/json" : "multipart/form-data";
          if (isServiceCode) {
            dio?.options.headers["service_code"] = "sl_customer";
          }
          //application/json-patch+json application/json
        }
        if (kDebugMode) {
          printLog(
            'before formData URL: ${dio?.options.baseUrl}$url Data:$data token: $_accessToken',
          );
        }
        FormData formData = FormData();

        if (!isMultipleFileUpload) {
          formData = FormData.fromMap(isFormData ? data : {});
        } else if (isMultipleFileUpload) {
          for (var files in data) {
            formData.files.addAll([
              MapEntry("images", await MultipartFile.fromFile(files.path)),
            ]);
          }
        }

        if (kDebugMode) {
          printLog(
            'URL:${dio?.options.baseUrl}$url Data:$data token: $_accessToken',
          );
        }

        var response = await dio?.post(
          url,
          // data: formData,
          data:
              isFormData
                  ? formData
                  : data == null
                  ? null
                  : isJsonEncodeRequired
                  ? jsonEncode(data)
                  : data,
          queryParameters: mQueryParameters,
        );

        if (kDebugMode) {
          printLog('URL:  $url\nData: $data\nResponse: $response');
        }

        AppHelper().hideLoader();
        return response;
      } on DioException catch (e) {
        printLog(e.response!);
        handelException(e);
        AppHelper().hideLoader();
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else if (e.response?.statusCode == 403 ||
            e.response?.statusCode == 400) {
          return e.response;
        } else if (e.response?.statusCode == 401) {
          AppHelper().logout();
          return e.response;
        } else {
          return null;
        }
      }
    } else {
      AppWidgets().getSnackBar(
        title: "Info",
        message: "No internet! Please connect your internet connection.",
      );
    }
    return null;
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
    if (_connectionController.value.isInternetConnected.isTrue) {
      dio?.options.headers["isApp"] = true;

      if (isLoaderRequired) {
        AppHelper().showLoader();
      }
      try {
        if (isHeaderRequired) {
          dio?.options.headers["Authorization"] = _accessToken;
          dio?.options.headers["Content-Type"] = "application/json";
        }
        if (kDebugMode) {
          debugPrint('URL:  $data');
        }
        var response = await dio?.put(
          url,
          data: data,
          queryParameters: mQueryParameters,
        );
        if (kDebugMode) {
          printLog('URL:  $url\nData: $data\nResponse: $response');
        }
        AppHelper().hideLoader();
        return response;
      } on DioException catch (e) {
        AppHelper().hideLoader();
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else {
          return null;
        }
      }
    } else {
      AppWidgets().getSnackBar(
        title: "Info",
        message: "No internet! Please connect your internet connection.",
      );
    }
    return null;
  }

  Future<Response?> delete(
    // BuildContext context,
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
    if (_connectionController.value.isInternetConnected.isTrue) {
      dio?.options.headers["isApp"] = true;

      if (isLoaderRequired) {
        AppHelper().showLoader();
      }

      if (kDebugMode) {
        printLog(
          'URL:  ${AppConfig.basePath}$url\nQueryParameters: $mQueryParameters',
        );
      }
      try {
        if (isHeaderRequired) {
          dio?.options.headers["Authorization"] = _accessToken;
          dio?.options.headers["Content-Type"] = "application/json";
        }

        Response? response = await dio?.delete(
          url,
          data: data,
          queryParameters: mQueryParameters,
        );

        printLog(
          'URL:  $url\nQueryParameters: $mQueryParameters\nResponse: $response',
        );
        AppHelper().hideLoader();
        return response;
      } on DioException catch (e) {
        AppHelper().hideLoader();
        if (!isHeaderRequired &&
            !e.response.toString().contains("<!DOCTYPE html>")) {
          return e.response;
        } else {
          return null;
        }
      }
    } else {
      AppWidgets().getSnackBar(
        title: "Info",
        message: "No internet! Please connect your internet connection.",
      );
    }
    return null;
  }

  Future<void> printCatch(DioException e, retry) async {
    if (kDebugMode) {
      printLog('printCatch:  ${e.response?.statusCode}');
    }

    if (e.response?.statusCode == HttpStatus.internalServerError) {
      if (kDebugMode) {
        printLog(
          'printCatch: Internal Server Error: ${e.response?.statusCode} ',
        );
      }
    }

    if (e.response?.statusCode == 400) {
    } else if (e.response?.statusCode == 401) {
      AppHelper().logout();
    } else if (e.response?.statusCode == 503) {
      AppWidgets().getSnackBar(
        title: "Info",
        message: "Unable Connect with server. Please try again later.",
      );
    } else {
      //TODO clear
      /* AppWidgets().showSimpleDialog(context, "Failed",
          "Something went wrong. Please try again later.", retry);*/
      /*  message:
      "Something went wrong. Please try again later.\nStatus Code: ${e.response != null ? e.response?.statusCode : ""}",
*/
      // FlightUpdateErrorModel error =
      //     flightUpdateErrorModelFromJson(e.response?.data);

      // AppWidgets().getSnackBar(
      //     title: "Failed",
      //     // message: "Something went wrong. Please try again later.",
      //     message: e.response!.data != null ? jsonDecode(e.response!.data)["message"].toString() : "error.message",
      //     waitingTime: 5,
      //     backgroundColor: AppColors.red);
    }
    if (e.response != null) {
      if (kDebugMode) {
        printLog('Error Response data:  ${e.response?.data}');
        printLog('Error Response headers:  ${e.response?.headers}');
        printLog('Error Response statusCode:  ${e.response?.statusCode}');
      }
    } else {
      if (kDebugMode) {
        printLog('Error Response message:  ${e.message}');
      }
    }
  }

  Future<dynamic> getDynamicApiData(url) async {
    var response = await Dio().get("${AppConfig.basePath}$url");
    return response;
  }

  void handelException(DioException e) {
    /*    try {
      List<ErrorResponse> errorResponse =
          errorResponseFromJson(e.response.toString());
      for (var element in errorResponse) {
        AppWidgets().getSnackBar(
            waitingTime: 4,
            title: element.status,
            message: element.message,
            backgroundColor: AppColors.red);
      }
    } catch (e) {
      printLog("catch e: $e", level: "e");
    }*/
  }
}
