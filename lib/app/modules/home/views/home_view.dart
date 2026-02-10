import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/dialog_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../controllers/home_controller.dart';
import 'widgets/compact_header.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_shimmer_loading.dart';
import 'widgets/profit_summary_card.dart';
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
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColors.white,
          appBar: HomeAppBar(
            profile: controller.profile.value,
            lastFourNumber: controller.lastFourNumber.value,
          ),
          body: controller.isLoading.value
              ? const HomeShimmerLoading()
              : RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: controller.refreshTrades,
                  child: CustomScrollView(
                    slivers: [
                  SliverToBoxAdapter(
                    child: CompactHeader(profile: controller.profile.value),
                  ),
                  SliverToBoxAdapter(
                    child: ProfitSummaryCard(
                      totalProfit: controller.totalProfit.value,
                      profitableCount: controller.getProfitableTradesCount(),
                      losingCount: controller.getLosingTradesCount(),
                      totalTrades: controller.trades.length,
                    ),
                  ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.1,
                            ),
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
                          style: sectionHeaderStyle(),
                        ),
                        SizedBox(width: 8.w),
                        Container(
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
                            style: badgeTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                  controller.trades.isEmpty
                      ? SliverFillRemaining(
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
                              style: emptyStateTitleStyle(),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Your trades will appear here',
                              style: emptyStateSubtitleStyle(
                                color: AppColors.textColor.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                        ),
                      )
                      : SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final trade = controller.trades[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: TradeCard(trade: trade),
                        );
                      }, childCount: controller.trades.length),
                    ),
                  ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
