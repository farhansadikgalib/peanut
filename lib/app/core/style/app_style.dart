import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

TextStyle textHeaderStyle({
  color = AppColors.textColor,
  double fontSize = 30,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle textAppBarStyle({
  color = AppColors.textColor,
  double fontSize = 16,
  fontWeight = FontWeight.w600,
  bool isGrayColor = false,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: isGrayColor ? AppColors.gray : color,
    fontWeight: fontWeight,
  );
}

TextStyle textRegularStyle({
  color = AppColors.textColor,
  double fontSize = 14,
  fontWeight = FontWeight.normal,
  bool isGrayColor = false,
  bool isWhiteColor = false,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
        ? AppColors.gray
        : color,
    fontWeight: fontWeight,
    //height: needHeight ? 1.0 : 0.0
  );
}

TextStyle drawerTextStyle({
  color = AppColors.white,
  double fontSize = 13,
  fontWeight = FontWeight.w500,
  bool isGrayColor = false,
  bool isWhiteColor = false,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
        ? AppColors.gray
        : color,
    fontWeight: fontWeight,
    //height: needHeight ? 1.0 : 0.0
  );
}

TextStyle textButtonStyle({
  color = AppColors.white,
  double fontSize = 18,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle textLineStyle({
  color = AppColors.textColor,
  double fontSize = 13,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

final hintStyle = TextStyle(
  fontSize: 14.sp,
  color: AppColors.gray,
  fontWeight: FontWeight.w500,
);

// Splash screen text styles
TextStyle splashTitleStyle({
  color = AppColors.white,
  double fontSize = 32,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: 1.15,
    letterSpacing: -0.5,
  );
}

TextStyle splashSubtitleStyle({
  color = AppColors.white,
  double fontSize = 15,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: 1.4,
  );
}

TextStyle splashButtonTextStyle({
  color = AppColors.white,
  double fontSize = 14,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Pricing screen text styles
TextStyle pricingTitleStyle({
  color = AppColors.white,
  double fontSize = 18,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle pricingSubtitleStyle({
  color = AppColors.textColor,
  double fontSize = 14,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: 1.4,
  );
}

TextStyle pricingTierNameStyle({
  color = AppColors.white,
  double fontSize = 16,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle pricingTierPriceStyle({
  color = AppColors.white,
  double fontSize = 16,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle pricingFeatureTextStyle({
  color = AppColors.white,
  double fontSize = 13,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    height: 1.5,
  );
}

TextStyle pricingFeatureBoldStyle({
  color = AppColors.white,
  double fontSize = 13,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Dialog text styles
TextStyle dialogTitleStyle({
  color = AppColors.black,
  double fontSize = 20,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle dialogBodyStyle({
  color = AppColors.textColor,
  double fontSize = 14,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle dialogButtonStyle({
  required Color color,
  double fontSize = 14,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Profile text styles
TextStyle profileNameStyle({
  color = AppColors.black,
  double fontSize = 22,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle profileBadgeStyle({
  color = AppColors.primaryColor,
  double fontSize = 14,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// App bar styles
TextStyle appBarTitleStyle({
  color = AppColors.black,
  double fontSize = 20,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Section header styles
TextStyle sectionHeaderStyle({
  color = AppColors.black,
  double fontSize = 16,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Badge styles
TextStyle badgeTextStyle({
  color = AppColors.white,
  double fontSize = 12,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle smallBadgeTextStyle({
  color = AppColors.white,
  double fontSize = 11,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Empty state styles
TextStyle emptyStateTitleStyle({
  color = AppColors.textColor,
  double fontSize = 18,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle emptyStateSubtitleStyle({
  required Color color,
  double fontSize = 14,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color);
}

// Trade card styles
TextStyle tradeSymbolStyle({
  color = AppColors.black,
  double fontSize = 17,
  fontWeight = FontWeight.w800,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle tradeProfitStyle({
  required Color color,
  double fontSize = 17,
  fontWeight = FontWeight.w800,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle tradeTimeStyle({
  required Color color,
  double fontSize = 10,
  fontWeight = FontWeight.w500,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle tradeIdStyle({
  required Color color,
  double fontSize = 10,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle tradeInfoLabelStyle({
  required Color color,
  double fontSize = 9,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle tradeInfoValueStyle({
  color = AppColors.black,
  double fontSize = 11,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Profit summary styles
TextStyle profitLabelStyle({
  color = AppColors.textColor,
  double fontSize = 12,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle profitValueStyle({
  required Color color,
  double fontSize = 24,
  fontWeight = FontWeight.w800,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: -0.5,
  );
}

TextStyle statLabelStyle({
  color = AppColors.textColor,
  double fontSize = 11,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle statValueStyle({
  required Color color,
  double fontSize = 16,
  fontWeight = FontWeight.w800,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Header styles
TextStyle headerWelcomeStyle({
  required Color color,
  double fontSize = 14,
  fontWeight = FontWeight.w500,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle headerNameStyle({
  color = AppColors.white,
  double fontSize = 22,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle headerInfoLabelStyle({
  required Color color,
  double fontSize = 12,
  fontWeight = FontWeight.w500,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle headerInfoValueStyle({
  color = AppColors.white,
  double fontSize = 18,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Compact header styles
TextStyle compactBalanceLabelStyle({
  required Color color,
  double fontSize = 11,
  fontWeight = FontWeight.w500,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle compactBalanceValueStyle({
  color = AppColors.white,
  double fontSize = 14,
  fontWeight = FontWeight.w700,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Button styles
TextStyle buttonTextStyle({
  Color? color,
  double? fontSize,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(
    fontSize: (fontSize ?? 16).sp,
    color: color ?? AppColors.white,
    fontWeight: fontWeight,
    letterSpacing: 0.5,
  );
}

// Input field styles
TextStyle inputTextStyle({
  required Color color,
  double fontSize = 16,
  fontWeight = FontWeight.w500,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle inputHintStyle({
  required Color color,
  double fontSize = 16,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle inputLabelStyle({
  required Color color,
  double fontSize = 14,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle inputFloatingLabelStyle({
  color = AppColors.primaryColor,
  double fontSize = 12,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle inputErrorStyle({
  color = AppColors.errorColor,
  double fontSize = 12,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle inputHelperStyle({
  required Color color,
  double fontSize = 12,
  fontWeight = FontWeight.w400,
}) {
  return TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

// Logo styles
TextStyle logoSloganStyle({
  color = AppColors.textColor,
  double fontSize = 16,
  fontWeight = FontWeight.w600,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: 0.3,
  );
}
