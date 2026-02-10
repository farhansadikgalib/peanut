import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/widget/app_logo.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'app_logo',
                child: const AppLogo(slogan: 'Start Trading. Stay Winning.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
