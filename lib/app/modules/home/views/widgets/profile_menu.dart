import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_helper.dart';
import '../../../../core/helper/dialog_helper.dart';
import '../../../../core/helper/haptic_helper.dart';
import '../../../../core/helper/shared_value_helper.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../data/remote/model/profile/profile_response.dart';

class ProfileMenu {
  static void show(BuildContext context, ProfileResponse? profile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ProfileMenuContent(profile: profile),
    );
  }
}

class ProfileMenuContent extends StatelessWidget {
  final ProfileResponse? profile;

  const ProfileMenuContent({
    super.key,
    this.profile,
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
            // Handle bar
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
                  // Profile Icon
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
                  SizedBox(height: 16.h),

                  // User Name
                  Text(
                    profile?.name ?? 'Trader',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // User ID
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                        SizedBox(width: 8.w),
                        Text(
                          'ID: ${userId.$}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  SizedBox(height: 24.h),

                  // Logout Button
                  InkWell(
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
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.dangerRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.dangerRed.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.dangerRed,
                          ),
                        ),
                      ),
                    ),
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
