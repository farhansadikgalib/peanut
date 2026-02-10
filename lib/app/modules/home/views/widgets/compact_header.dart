import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../data/remote/model/profile/profile_response.dart';

class CompactHeader extends StatelessWidget {
  final ProfileResponse? profile;

  const CompactHeader({
    super.key,
    this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildBalanceItem(
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
            child: _buildBalanceItem(
              'Equity',
              '\$${(profile?.equity ?? 0.0).toStringAsFixed(2)}',
              Icons.trending_up,
            ),
          ),
          Container(
            width: 1,
            height: 40.h,
            color: AppColors.white.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _buildBalanceItem(
              'Margin',
              '\$${(profile?.freeMargin ?? 0.0).toStringAsFixed(2)}',
              Icons.pie_chart,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.white.withValues(alpha: 0.9),
          size: 18.r,
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
