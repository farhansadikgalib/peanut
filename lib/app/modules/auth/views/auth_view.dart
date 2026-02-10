import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/haptic_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../../../core/widget/app_logo.dart';
import '../../../core/widget/custom_button.dart';
import '../controllers/auth_controller.dart';
import 'widgets/auth_login_form.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 60.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'app_logo',
                    child: const AppLogo(slogan: ''),
                  ),
                  Text(
                    'Peanut',
                    style: appNameStyle(),
                  ),
                  AppWidgets().gapH(8),
                  Text(
                    'Start Trading. Stay Winning.',
                    style: logoSloganStyle(),
                  ),
                  AppWidgets().gapH(32),
                  const AuthLoginForm(),
                  AppWidgets().gapH(32),
                  CustomButton(
                    text: 'Sign In',
                    onTap: () {
                      HapticHelper.heavy();
                      controller.signIn();
                    },
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
