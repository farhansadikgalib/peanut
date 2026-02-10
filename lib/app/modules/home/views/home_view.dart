import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../controllers/home_controller.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/shimmer_widget.dart';
import 'widgets/summary_card.dart';
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
              ? const ShimmerLoading()
              : RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: controller.refreshTrades,
                  child: CustomScrollView(
                    slivers: [
                  SliverToBoxAdapter(
                    child: MergedSummaryCard(
                      profile: controller.profile.value,
                      totalProfit: controller.totalProfit.value,
                      profitableCount: controller.getProfitableTradesCount(),
                      losingCount: controller.getLosingTradesCount(),
                    ),
                  ),

                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Open Trades',
                              style: sectionHeaderStyle(fontSize: 16),
                            ),
                            AppWidgets().gapH(2),
                            Text(
                              'Active Positions',
                              style: textRegularStyle(
                                color: AppColors.textColor.withValues(alpha: 0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${controller.trades.length}',
                            style: badgeTextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                            AppWidgets().gapH(16),
                            Text(
                              'No Open Trades',
                              style: emptyStateTitleStyle(),
                            ),
                            AppWidgets().gapH(8),
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
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 40.h),
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
