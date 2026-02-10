import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

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
