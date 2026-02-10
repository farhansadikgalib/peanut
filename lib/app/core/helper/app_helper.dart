import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  /// Hides the currently displayed loading indicator if it's visible.
  void hideLoader() {
    // Check if loader is currently showing before dismissing
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  /// Logs out the current user and navigates to onboarding screen.
  /// Clears all user data and removes all previous routes from navigation stack.
  void logout() {
    // Clear stored authentication data
    AuthHelper().clearUserData();
    // Navigate to onboarding screen and remove all previous routes
    Get.offAllNamed(Routes.AUTH);
  }

  String getDayNameAndDateYearOnly(DateTime dateTime) {
    //Input: "2022-11-14 12:15:20"
    //Output: "12:15"
    return DateFormat('dd MMMM yyyy, EEEE').format(dateTime);
  }

  int timeDifference({expiredTime}) {
    final expiredTimeData = DateTime.parse(expiredTime);
    final todayTime = DateTime.now();
    final difference = expiredTimeData.difference(todayTime).inMinutes;
    return difference;
  }

  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  bool isKeyBoardVisible(context) {
    return MediaQuery.of(context).viewInsets.bottom != 0 ? false : true;
  }

  String getFormattedDateOnly(
    DateTime dateTime, {
    isWeekDayNameOnly = false,
    isDateOnly = true,
    isDayNameAndDateOnly = false,
  }) {
    if (isWeekDayNameOnly) {
      return DateFormat('EEEE').format(dateTime);
    } else if (isDateOnly) {
      return DateFormat('dd MMM, yyyy').format(dateTime);
    } else if (isDayNameAndDateOnly) {
      return DateFormat('EEEE').format(dateTime);
    }
    return DateFormat('EE, dd MMM, yyyy').format(dateTime);
  }

  String getDayAndMonthOnly(DateTime dateTime) {
    return DateFormat('dd MMM').format(dateTime);
  }

  String getDayNameOnly(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  void scrollFlightListToTop(scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}
