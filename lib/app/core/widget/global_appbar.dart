import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../style/app_colors.dart';

AppBar globalAppBar(
  BuildContext context,
  String appbarTitle, {
  bool showBackButton = true,
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 0,
    titleSpacing: showBackButton ? 0 : 10,
    backgroundColor: AppColors.darkBackground,
    leading: showBackButton
        ? Center(
            child: InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white.withOpacity(0.12),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: AppColors.white,
                  size: 24.sp,
                ),
              ),
            ),
          )
        : null,
    title: Text(
      appbarTitle,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    ),
    centerTitle: true,
    actions: actions,
  );
}
