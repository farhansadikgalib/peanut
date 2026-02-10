import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/helper/dialog_helper.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          DialogHelper().appExit(context);
        }
      },
      child: Scaffold(
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
          return _buildShimmerLoading();
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
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.show_chart,
                          color: AppColors.primaryColor,
                          size: 16.r,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Open Trades',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Obx(() => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              '${controller.trades.length}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
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
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Shimmer for Compact Header
            Container(
              height: 80.h,
              margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            // Shimmer for Profit Summary
            Container(
              height: 120.h,
              margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            // Section Title Shimmer
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 30.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ],
              ),
            ),

            // Shimmer for Trade Cards
            ...List.generate(
              5,
              (index) => Container(
                height: 140.h,
                margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
