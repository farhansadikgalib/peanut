import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../data/remote/model/home/trade_response.dart';

class TradeCard extends StatelessWidget {
  final Trade trade;

  const TradeCard({
    super.key,
    required this.trade,
  });

  @override
  Widget build(BuildContext context) {
    final isProfitable = (trade.profit ?? 0.0) >= 0;
    final profitColor = isProfitable ? AppColors.successGreen : AppColors.dangerRed;
    final tradeType = trade.getTradeType();
    final tradeTypeColor = tradeType == "BUY" ? AppColors.successGreen : AppColors.dangerRed;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: tradeTypeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: tradeTypeColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tradeType,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: tradeTypeColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      trade.symbol ?? 'N/A',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  '#${trade.id ?? 0}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                // Profit/Loss
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profit/Loss',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          isProfitable ? Icons.arrow_upward : Icons.arrow_downward,
                          color: profitColor,
                          size: 16.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          trade.getProfitWithSign(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: profitColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Price Info
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        'Volume',
                        '${trade.volume ?? 0.0}',
                        Icons.bar_chart,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildInfoRow(
                        'Open Price',
                        '${trade.openPrice ?? 0.0}',
                        Icons.price_change,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        'Current',
                        '${trade.currentPrice ?? 0.0}',
                        Icons.show_chart,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildInfoRow(
                        'S/L',
                        '${trade.stopLoss ?? 0.0}',
                        Icons.stop_circle_outlined,
                      ),
                    ),
                  ],
                ),

                // Open Time
                if (trade.openTime != null) ...[
                  SizedBox(height: 10.h),
                  Divider(
                    color: AppColors.gray.withValues(alpha: 0.3),
                    thickness: 1,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.textColor,
                        size: 14.r,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Opened: ${_formatDateTime(trade.openTime!)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ],

                // Comment
                if (trade.comment != null && trade.comment!.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.comment,
                        color: AppColors.textColor,
                        size: 14.r,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          trade.comment!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 16.r,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }
}
