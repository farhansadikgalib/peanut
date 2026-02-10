import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_style.dart';
import '../../../../data/remote/model/home/trade_response.dart';

class TradeCard extends StatelessWidget {
  final Trade trade;

  const TradeCard({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    final isProfitable = (trade.profit ?? 0.0) >= 0;
    final profitColor = isProfitable
        ? AppColors.successGreen
        : AppColors.dangerRed;
    final tradeType = trade.getTradeType();
    final tradeTypeColor = tradeType == "BUY"
        ? AppColors.successGreen
        : AppColors.dangerRed;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: profitColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: profitColor.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            children: [
              // Trade Type Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: tradeTypeColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  tradeType,
                  style: smallBadgeTextStyle(),
                ),
              ),
              SizedBox(width: 10.w),
              // Symbol
              Expanded(
                child: Text(
                  trade.symbol ?? 'N/A',
                  style: tradeSymbolStyle(),
                ),
              ),
              // Profit/Loss
              Row(
                children: [
                  Icon(
                    isProfitable ? Icons.trending_up : Icons.trending_down,
                    color: profitColor,
                    size: 18.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    trade.getProfitWithSign(),
                    style: tradeProfitStyle(color: profitColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Price Grid
          Row(
            children: [
              Expanded(
                child: _buildCompactInfo(
                  'Vol',
                  '${trade.volume ?? 0.0}',
                  Icons.bar_chart_rounded,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildCompactInfo(
                  'Open',
                  '${trade.openPrice ?? 0.0}',
                  Icons.arrow_circle_up_outlined,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildCompactInfo(
                  'Current',
                  '${trade.currentPrice ?? 0.0}',
                  Icons.show_chart,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildCompactInfo(
                  'S/L',
                  '${trade.stopLoss ?? 0.0}',
                  Icons.shield_outlined,
                ),
              ),
            ],
          ),

          // Footer with time and ID
          if (trade.openTime != null || trade.id != null) ...[
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (trade.openTime != null)
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: AppColors.textColor.withValues(alpha: 0.6),
                        size: 12.r,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDateTime(trade.openTime!),
                        style: tradeTimeStyle(
                          color: AppColors.textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                if (trade.id != null)
                  Text(
                    '#${trade.id}',
                    style: tradeIdStyle(
                      color: AppColors.textColor.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCompactInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor.withValues(alpha: 0.7),
          size: 14.r,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: tradeInfoLabelStyle(
            color: AppColors.textColor.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: tradeInfoValueStyle(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, HH:mm').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }
}
