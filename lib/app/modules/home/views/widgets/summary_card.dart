import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_widgets.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_style.dart';
import '../../../../data/remote/model/profile/profile_response.dart';

class MergedSummaryCard extends StatelessWidget {
  final ProfileResponse? profile;
  final double totalProfit;
  final int profitableCount;
  final int losingCount;

  const MergedSummaryCard({
    super.key,
    this.profile,
    required this.totalProfit,
    required this.profitableCount,
    required this.losingCount,
  });

  @override
  Widget build(BuildContext context) {
    final isProfitable = totalProfit >= 0;
    final profitColor = isProfitable ? AppColors.successGreen : AppColors.dangerRed;

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
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
      child: Column(
        children: [
          // Top Row: Balance, Equity, Margin
          Row(
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
          
          // Divider
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Container(
              height: 1,
              color: AppColors.white.withValues(alpha: 0.3),
            ),
          ),
          
          // Bottom Row: Total P/L, Win, Loss
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildProfitItem(
                  'Total P/L',
                  _getFormattedProfit(),
                  isProfitable ? Icons.trending_up : Icons.trending_down,
                  profitColor,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppColors.white.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  'Win',
                  profitableCount.toString(),
                  AppColors.successGreen,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: AppColors.white.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  'Loss',
                  losingCount.toString(),
                  AppColors.dangerRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.white.withValues(alpha: 0.9), size: 18.r),
        AppWidgets().gapH(6),
        Text(
          label,
          style: compactBalanceLabelStyle(
            color: AppColors.white.withValues(alpha: 0.85),
          ),
        ),
        AppWidgets().gapH(4),
        Text(
          value,
          style: compactBalanceValueStyle(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildProfitItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white.withValues(alpha: 0.9), size: 18.r),
            AppWidgets().gapW(6),
            Text(
              label,
              style: compactBalanceLabelStyle(
                color: AppColors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        AppWidgets().gapH(6),
        Text(
          value,
          style: compactBalanceValueStyle(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: compactBalanceLabelStyle(
            color: AppColors.white.withValues(alpha: 0.85),
          ),
        ),
        AppWidgets().gapH(6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            value,
            style: compactBalanceValueStyle(fontSize: 18),
          ),
        ),
      ],
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
