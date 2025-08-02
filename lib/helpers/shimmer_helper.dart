import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/widgets/my_widgets/my_shimmer.dart';

mixin ShimmerHelper {
  Widget horizontalListShimmer({
    required double height,
    required double width,
    required double separator,
    double startPadding = 20,
    double bottomPadding = 0,
    double radius = 5,
    int count = 8,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: startPadding.w,
        bottom: bottomPadding.h,
      ),
      child: SizedBox(
        height: height.h,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              MyShimmer(height: height, width: width, radius: radius),
          separatorBuilder: (context, index) => SizedBox(width: separator.w),
          itemCount: count,
        ),
      ),
    );
  }

  Widget verticalListShimmer({
    required double height,
    double width = double.infinity,
    required double separator,
    double horPadding = 20,
    double topPadding = 20,
    double radius = 5,
    int count = 8,
  }) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        right: horPadding.w,
        left: horPadding.w,
        top: topPadding.h,
      ),
      itemBuilder: (context, index) => MyShimmer(
        height: height,
        width: width,
        radius: radius,
      ),
      separatorBuilder: (context, index) => SizedBox(height: separator.h),
      itemCount: count,
    );
  }
}
