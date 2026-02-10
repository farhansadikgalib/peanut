import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/haptic_helper.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_style.dart';
import '../../../../data/remote/model/auth/last_four_number_response.dart';
import '../../../../data/remote/model/profile/profile_response.dart';
import 'profile_menu.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileResponse? profile;
  final LastFourNumberResponse? lastFourNumber;

  const HomeAppBar({
    super.key,
    this.profile,
    this.lastFourNumber,
  });

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 16.w,
        title: Row(
          children: [
            // App Logo with Gradient
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.trending_up,
                color: AppColors.white,
                size: 22.r,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Peanut',
                  style: appBarTitleStyle(fontSize: 18,color: AppColors.primaryColor),
                ),
                Text(
                  'Trading Platform',
                  style: textRegularStyle(
                    color: AppColors.textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Profile Button
          GestureDetector(
            onTap: () {
              HapticHelper.light();
              ProfileMenu.show(context, profile, lastFourNumber);
            },
            child: Container(
              margin: EdgeInsets.only(right: 16.w),
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.5,
                ),
              ),
              child: Container(
                width: 38.r,
                height: 38.r,
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
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 22.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
