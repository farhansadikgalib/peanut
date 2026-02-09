import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';

class AppLogo extends StatelessWidget {
  final String slogan;
  final double? logoSize;
  final double? iconSize;

  const AppLogo({
    super.key,
    required this.slogan,
    this.logoSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo icon
        Container(
          width: logoSize ?? 80.r,
          height: logoSize ?? 80.r,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.infoCyan,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Icon(
            Icons.trending_up_rounded,
            color: AppColors.white,
            size: iconSize ?? 48.r,
          ),
        ),
        SizedBox(height: 16.h),

        // Slogan
        Text(
          slogan,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
