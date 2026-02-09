import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/app/core/helper/auth_helper.dart';
import '../../../data/remote/repository/auth/auth_repository.dart';
import '../../../data/remote/model/auth/login_response.dart';
import '../../../core/helper/shared_value_helper.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      loginController.text = "2088888";
      passwordController.text = "ral11lod";
    }
  }

  @override
  void onClose() {
    loginController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signIn() async {
    // Validate inputs
    if (loginController.text.trim().isEmpty) {
      AppWidgets().getSnackBar(
        title: "Error",
        message: "Please enter your login ID",
      );
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      AppWidgets().getSnackBar(
        title: "Error",
        message: "Please enter your password",
      );
      return;
    }

    LoginResponse response = await AuthRepository().login(
      loginController.text.trim(),
      passwordController.text.trim(),
    );

    if (response.result == true && response.token != null) {
      AuthHelper().setUserData(response);
      userId.$ = loginController.text.trim();
      userId.save();

      AppWidgets().getSnackBar(title: "Success", message: "Login successful!");
      Get.offAllNamed(Routes.HOME);
    } else {
      AppWidgets().getSnackBar(
        title: "Login Failed",
        message: "Invalid credentials. Please try again.",
      );
    }
  }
}
