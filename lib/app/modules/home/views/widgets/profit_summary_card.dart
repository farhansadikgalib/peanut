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
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Row(
        children: [
          // Total Profit Section
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isProfitable
                      ? [
                          AppColors.successGreen.withValues(alpha: 0.1),
                          AppColors.successGreen.withValues(alpha: 0.05),
                        ]
                      : [
                          AppColors.dangerRed.withValues(alpha: 0.1),
                          AppColors.dangerRed.withValues(alpha: 0.05),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: profitColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isProfitable ? Icons.trending_up : Icons.trending_down,
                        color: profitColor,
                        size: 18.r,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Total P/L',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _getFormattedProfit(),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: profitColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Stats Section
          Expanded(
            child: Column(
              children: [
                _buildCompactStat(
                  profitableCount.toString(),
                  'Win',
                  AppColors.successGreen,
                ),
                SizedBox(height: 8.h),
                _buildCompactStat(
                  losingCount.toString(),
                  'Loss',
                  AppColors.dangerRed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStat(String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: color,
            ),
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
}
