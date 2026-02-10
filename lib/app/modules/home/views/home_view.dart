import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/style/app_colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/compact_header.dart';
import 'widgets/profit_summary_card.dart';
import 'widgets/profile_menu.dart';
import 'widgets/trade_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.trending_up,
                color: AppColors.white,
                size: 20.r,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Peanut',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              ProfileMenu.show(context, controller.profile.value);
            },
            child: Container(
              margin: EdgeInsets.only(right: 16.w),
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
              ),
              child: Container(
                width: 36.r,
                height: 36.r,
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
                  size: 20.r,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: controller.refreshTrades,
          child: CustomScrollView(
            slivers: [
              // Compact Header with balance info
              SliverToBoxAdapter(
                child: Obx(() => CompactHeader(
                      profile: controller.profile.value,
                    )),
              ),

              // Profit Summary Card
              SliverToBoxAdapter(
                child: Obx(() => ProfitSummaryCard(
                      totalProfit: controller.totalProfit.value,
                      profitableCount: controller.getProfitableTradesCount(),
                      losingCount: controller.getLosingTradesCount(),
                      totalTrades: controller.trades.length,
                    )),
              ),

              // Section Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Open Trades',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                      Obx(() => Text(
                            '${controller.trades.length} ${controller.trades.length == 1 ? 'Trade' : 'Trades'}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              // Trades List
              Obx(() {
                if (controller.trades.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 64.r,
                            color: AppColors.textColor.withValues(alpha: 0.3),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No Open Trades',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Your trades will appear here',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final trade = controller.trades[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: TradeCard(trade: trade),
                        );
                      },
                      childCount: controller.trades.length,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
