import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../style/app_colors.dart';
import 'auth_helper.dart';

class AppHelper {
  Future<void> showLoader({bool dismissOnTap = true}) {
    EasyLoading.instance
      // Custom wave spinner widget
      ..indicatorWidget = Container(
        height: 120,
        width: 120,
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: const SpinKitWaveSpinner(
          color: AppColors.primaryColor,
          size: 50.0,
        ),
      )
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..indicatorColor = Colors.transparent
      ..maskColor = Colors.transparent
      ..backgroundColor = Colors.transparent
      ..boxShadow = []
      ..contentPadding = EdgeInsets.zero
      ..radius = 5
      ..indicatorSize = 80.0
      // Disable user interactions while loading
      ..userInteractions = false
      ..dismissOnTap = dismissOnTap;

    return EasyLoading.show();
  }

  void hideLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }


  void logout() {
    AuthHelper().clearUserData();
    Get.offAllNamed(Routes.AUTH);
  }


}
