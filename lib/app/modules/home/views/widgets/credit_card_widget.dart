import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_widgets.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_style.dart';

class CreditCardWidget extends StatelessWidget {
  final String? lastFourDigits;

  const CreditCardWidget({
    super.key,
    this.lastFourDigits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.credit_card,
                color: AppColors.white,
                size: 32.r,
              ),
            ],
          ),
          AppWidgets().gapH(16),

          Row(
            children: [
              _buildDotGroup(),
              AppWidgets().gapW(12),
              _buildDotGroup(),
              AppWidgets().gapW(12),
              _buildDotGroup(),
              AppWidgets().gapW(12),
              Text(
                lastFourDigits ?? '****',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          AppWidgets().gapH(20),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: AppColors.white,
                      size: 16.r,
                    ),
                    AppWidgets().gapW(6),
                    Text(
                      'VERIFIED',
                      style: textRegularStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDotGroup() {
    return Row(
      children: List.generate(
        4,
        (index) => Container(
          margin: EdgeInsets.only(right: index < 3 ? 4.w : 0),
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
