import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import 'app_widgets.dart';
import 'debounce_helper.dart';
import 'haptic_helper.dart';

class DialogHelper {
  void appExit(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Exit App',
              style: dialogTitleStyle(),
            ),
            SizedBox(height: 12.h),
            Text(
              'Are you sure you want to exit?',
              textAlign: TextAlign.center,
              style: dialogBodyStyle(),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: _modernButton(
                    context: context,
                    title: 'Cancel',
                    isPrimary: false,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _modernButton(
                    context: context,
                    title: 'Exit',
                    isPrimary: true,
                    onTap: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else {
                        exit(0);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void logoutDialog(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Logout',
              style: dialogTitleStyle(),
            ),
            SizedBox(height: 12.h),
            Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: dialogBodyStyle(),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: _modernButton(
                    context: context,
                    title: 'Cancel',
                    isPrimary: false,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _modernButton(
                    context: context,
                    title: 'Logout',
                    isPrimary: true,
                    color: AppColors.dangerRed,
                    onTap: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernButton({
    required BuildContext context,
    required String title,
    required bool isPrimary,
    required VoidCallback onTap,
    Color? color,
  }) {
    final buttonColor = color ?? AppColors.primaryColor;
    
    return InkWell(
      onTap: () {
        HapticHelper.light();
        DebounceHelper().debounce(
          time: 300,
          tag: DebounceHelper.buttonTag,
          onMethod: () {
            onTap();
            DebounceHelper().killAllDebounce();
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isPrimary ? buttonColor : AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isPrimary ? buttonColor : AppColors.gray.withValues(alpha: 0.3),
            width: isPrimary ? 0 : 1.5,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: dialogButtonStyle(
              color: isPrimary ? AppColors.white : AppColors.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Future customDialogBox(
    BuildContext context,
    title, {
    icon,
    leftButtonTitle = "No",
    rightButtonTitle = "Yes",
    leftButtonOnTap,
    rightButtonOnTap,
    isSvgIcon = false,
    hasCustomBody = false,
    body,
    isCenter = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            actionsAlignment:
                isCenter ? MainAxisAlignment.center : MainAxisAlignment.end,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
            ),
            //titlePadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            // contentPadding: const EdgeInsets.fromLTRB(mainInsidePadding*2.5,mainInsidePadding*2.5,mainInsidePadding,mainInsidePadding),
            /*title: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/app_logo.png',
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("Alert!",
                    style: TextStyle(
                      color: AppColors.white,
                    ))
              ],
            ),
          ),*/
            content:
                !hasCustomBody
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !isSvgIcon && icon != null
                            ? Image.asset(icon, width: 40, height: 40)
                            : isSvgIcon && icon != null
                            ? Image.asset(icon, width: 40, height: 40)
                            : const SizedBox(),
                        icon != null ? AppWidgets().gapH8() : const SizedBox(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 190.w,
                              child: Text(
                                title.toString(),
                                textAlign: TextAlign.center,
                                style: textRegularStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    : body,
            //actionsPadding: EdgeInsets.fromLTRB(mainInsidePadding, mainInsidePadding, mainInsidePadding*2, mainInsidePadding*2),
            actions: <Widget>[
              leftButtonOnTap != null
                  ? buttonWidget(
                    onTap: () => leftButtonOnTap(),
                    title: leftButtonTitle,
                    anotherStyle: false,
                  )
                  : const SizedBox(),
              AppWidgets().gapW(1),
              rightButtonOnTap != null
                  ? buttonWidget(
                    onTap: () => rightButtonOnTap(),
                    title: rightButtonTitle,
                    anotherStyle: true,
                  )
                  : const SizedBox(),
            ],
          ),
    );
  }

  Future customBackDialog(
    BuildContext context,
    title, {
    subTitle,
    icon,
    leftButtonTitle,
    rightButtonTitle,
    leftButtonOnTap,
    rightButtonOnTap,
    iconVisibility = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            actionsAlignment: MainAxisAlignment.center,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      iconVisibility
                          ? Image.asset(icon, width: 40, height: 40)
                          : const SizedBox(),
                      iconVisibility
                          ? AppWidgets().gapH12()
                          : AppWidgets().gapH(2.0),
                      SizedBox(
                        width: 190.w,
                        child: Text(
                          title.toString(),
                          textAlign: TextAlign.center,
                          style: textRegularStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      subTitle != null
                          ? Container(
                            width: 190.w,
                            margin: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              subTitle.toString(),
                              textAlign: TextAlign.center,
                              style: textRegularStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray,
                              ),
                            ),
                          )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            actionsPadding: const EdgeInsets.fromLTRB(
              mainInsidePadding,
              0.0,
              mainInsidePadding,
              20.0,
            ),
            actions: <Widget>[
              leftButtonOnTap != null
                  ? buttonWidget(
                    onTap: () => leftButtonOnTap(),
                    title: leftButtonTitle.toString(),
                    anotherStyle: false,
                  )
                  : const SizedBox(),
              AppWidgets().gapW(1),
              rightButtonOnTap != null
                  ? buttonWidget(
                    onTap: () => rightButtonOnTap(),
                    title: rightButtonTitle.toString(),
                    anotherStyle: true,
                  )
                  : const SizedBox(),
            ],
          ),
    );
  }

  Future customDialogBoxWithBody(
    BuildContext context,
    title, {
    subtitle,
    icon,
    isSvgIcon = false,
    body,
    barrierDismissal = true,
    contentPadding,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissal,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
            ),
            contentPadding:
                contentPadding ??
                const EdgeInsets.fromLTRB(
                  mainInsidePadding * 2.5,
                  mainInsidePadding * 2.5,
                  mainInsidePadding,
                  mainInsidePadding * 2.5,
                ),
            content: body,
          ),
    );
  }

  Container buttonWidget({anotherStyle = false, title, onTap}) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: anotherStyle ? AppColors.primaryColor : Colors.transparent,
        ),
        gradient: RadialGradient(
          colors:
              anotherStyle
                  ? [AppColors.white, AppColors.white]
                  : [AppColors.primaryColor, AppColors.primaryColor],
          radius: 2.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            DebounceHelper().debounce(
              time: 300,
              tag: DebounceHelper.buttonTag,
              onMethod: () {
                onTap();
                DebounceHelper().killAllDebounce();
              },
            );
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                title,
                style: textRegularStyle(
                  color:
                      anotherStyle ? AppColors.primaryColor : AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
