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
        // Logo icon - using actual logo asset
        Image.asset(
          'assets/png/logo.png',
          width: logoSize ?? 80.r,
          height: logoSize ?? 80.r,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 16.h),

        // Slogan
        Text(
          slogan,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
