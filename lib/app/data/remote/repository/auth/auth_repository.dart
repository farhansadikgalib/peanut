import 'dart:io';

import 'package:flutter/foundation.dart';
import '../../../../core/services/network/api_client.dart';
import '../../../../core/services/network/api_end_points.dart';
import '../../model/auth/login_response.dart';

class AuthRepository {
  Future<LoginResponse> login(String email, String password) async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      {
        "email": email,
        "password": password,
        "device_name": kDebugMode
            ? "postman"
            : Platform.isAndroid
            ? "android_device"
            : "ios_device",
        "revoke_other_tokens": kDebugMode ? false : true,
      },
      login,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return loginResponseFromJson(response.toString());
  }
}
