import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_style.dart';

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

        Text(
          slogan,
          style: logoSloganStyle(),
        ),
      ],
    );
  }
}
