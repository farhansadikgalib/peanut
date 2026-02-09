import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_widgets.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/auth_logo.dart';
import '../../../core/widget/primary_button.dart';
import '../controllers/auth_controller.dart';
import 'widgets/auth_login_form.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 60.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Section
                  const AuthLogo(
                    slogan: 'Trade Smart, Trade Secure',
                  ),
                  AppWidgets().gapH(32),

                  // Login Form
                  const AuthLoginForm(),
                  AppWidgets().gapH(32),


                  // Login Button
                  PrimaryButton(
                    text: 'Sign In',
                    onTap: () => controller.signIn(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
