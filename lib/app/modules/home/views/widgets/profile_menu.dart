import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_helper.dart';
import '../../../../core/helper/app_widgets.dart';
import '../../../../core/helper/dialog_helper.dart';
import '../../../../core/helper/haptic_helper.dart';
import '../../../../core/helper/shared_value_helper.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../data/remote/model/auth/last_four_number_response.dart';
import '../../../../data/remote/model/profile/profile_response.dart';
import 'credit_card_widget.dart';

class ProfileMenu {
  static void show(
    BuildContext context,
    ProfileResponse? profile,
    LastFourNumberResponse? lastFourNumber,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ProfileMenuContent(
        profile: profile,
        lastFourNumber: lastFourNumber,
      ),
    );
  }
}

class ProfileMenuContent extends StatelessWidget {
  final ProfileResponse? profile;
  final LastFourNumberResponse? lastFourNumber;

  const ProfileMenuContent({
    super.key,
    this.profile,
    this.lastFourNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.gray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Container(
                    width: 80.r,
                    height: 80.r,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 40.r,
                    ),
                  ),
                  AppWidgets().gapH(16),

                  Text(
                    profile?.name ?? 'Trader',
                    style: profileNameStyle(),
                  ),
                  AppWidgets().gapH(8),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.badge,
                          color: AppColors.primaryColor,
                        size: 16.r,
                      ),
                      AppWidgets().gapW(8),
                      Text(
                          'ID: ${userId.$}',
                          style: profileBadgeStyle(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Credit Card Widget
                  CreditCardWidget(
                    lastFourDigits: lastFourNumber?.getLastFourDigits(),
                  ),

                  AppWidgets().gapH(24),

                  CustomButton(
                    text: 'Logout',
                    backgroundColor: AppColors.dangerRed,
                    onTap: () {
                      HapticHelper.heavy();
                      Navigator.pop(context);
                      DialogHelper().logoutDialog(
                        context,
                        onConfirm: () {
                          AppHelper().logout();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
