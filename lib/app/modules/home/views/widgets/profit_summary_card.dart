import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';

class ProfitSummaryCard extends StatelessWidget {
  final double totalProfit;
  final int profitableCount;
  final int losingCount;
  final int totalTrades;

  const ProfitSummaryCard({
    super.key,
    required this.totalProfit,
    required this.profitableCount,
    required this.losingCount,
    required this.totalTrades,
  });

  @override
  Widget build(BuildContext context) {
    final isProfitable = totalProfit >= 0;
    final profitColor = isProfitable ? AppColors.successGreen : AppColors.dangerRed;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.gray.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
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
              Text(
                'Total Profit/Loss',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: profitColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      isProfitable ? Icons.trending_up : Icons.trending_down,
                      color: profitColor,
                      size: 16.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isProfitable ? 'Profit' : 'Loss',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: profitColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _getFormattedProfit(),
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              color: profitColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          Divider(
            color: AppColors.gray.withValues(alpha: 0.3),
            thickness: 1,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Winning',
                  profitableCount.toString(),
                  AppColors.successGreen,
                  Icons.arrow_upward,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppColors.gray.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  'Losing',
                  losingCount.toString(),
                  AppColors.dangerRed,
                  Icons.arrow_downward,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppColors.gray.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  'Total',
                  totalTrades.toString(),
                  AppColors.primaryColor,
                  Icons.list_alt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getFormattedProfit() {
    if (totalProfit > 0) {
      return '+\$${totalProfit.toStringAsFixed(2)}';
    } else if (totalProfit < 0) {
      return '-\$${totalProfit.abs().toStringAsFixed(2)}';
    }
    return '\$0.00';
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20.r,
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
