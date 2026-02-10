import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_helper.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/profit_summary_card.dart';
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
        title: Text(
          'Trading Dashboard',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: AppColors.primaryColor,
              size: 24.r,
            ),
            onPressed: () {
              AppHelper().logout();
            },
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
              // Header with user info
              SliverToBoxAdapter(
                child: HomeHeader(
                  profile: controller.profile.value,
                ),
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
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
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
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final trade = controller.trades[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
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
