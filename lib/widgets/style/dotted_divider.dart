import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedDivider extends StatefulWidget {
  final double vertical;
  final double horizontal;
  final Axis axis;
  final double height;
  final int count;
  final Color? color;

  const DottedDivider({
    this.vertical = 10,
    this.horizontal = 0,
    this.axis = Axis.horizontal,
    this.height = 1,
    this.count = 200,
    this.color,
    super.key,
  });

  @override
  State<DottedDivider> createState() => _DottedDividerState();
}

class _DottedDividerState extends State<DottedDivider> {
  Color get color => widget.color ?? const Color(0xffD4D4D4).withOpacity(.7);

  @override
  Widget build(BuildContext context) {
    return widget.axis == Axis.horizontal
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: widget.vertical.h, horizontal: widget.horizontal.w),
            child: SizedBox(
              height: widget.height.h,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  height: 1.h,
                  width: 3.w,
                  color: color,
                ),
                separatorBuilder: (context, index) => SizedBox(width: 3.w),
                itemCount: widget.count,
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.horizontal.w),
            child: SizedBox(
              width: 1.w,
              height: widget.height.h,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  height: 3.h,
                  width: 1.w,
                  color: color,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 3.h),
                itemCount: widget.count,
              ),
            ),
          );
  }
}
