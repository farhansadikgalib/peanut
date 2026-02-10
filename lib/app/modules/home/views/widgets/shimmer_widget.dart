import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/app_widgets.dart';

import '../../../../core/helper/app_widgets.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Compact Header Shimmer
            Container(
              height: 80.h,
              margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            // Profit Summary Card Shimmer
            Container(
              height: 120.h,
              margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            // Section Header Shimmer
            Container(
              margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      AppWidgets().gapH(6),
                      Container(
                        width: 80.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ],
              ),
            ),

            // Trade Cards Shimmer
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
