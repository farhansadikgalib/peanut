import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_style.dart';
import '../../../../data/remote/model/profile/profile_response.dart';

class HomeHeader extends StatelessWidget {
  final ProfileResponse? profile;

  const HomeHeader({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: headerWelcomeStyle(
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    profile?.name ?? 'Trader',
                    style: headerNameStyle(),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.person, color: AppColors.white, size: 28.r),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: AppColors.white.withValues(alpha: 0.3), thickness: 1),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Balance',
                  '\$${(profile?.balance ?? 0.0).toStringAsFixed(2)}',
                  Icons.account_balance_wallet,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppColors.white.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildInfoItem(
                  'Equity',
                  '\$${(profile?.equity ?? 0.0).toStringAsFixed(2)}',
                  Icons.trending_up,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.white.withValues(alpha: 0.9),
              size: 18.r,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: headerInfoLabelStyle(
                color: AppColors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: headerInfoValueStyle(),
        ),
      ],
    );
  }
}
