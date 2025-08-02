import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatefulWidget {
  final double height;
  final double width;
  final double radius;
  final double startMargin;
  final double endMargin;
  final double topMargin;
  final double bottomMargin;

  const MyShimmer({
    required this.height,
    this.width = double.infinity,
    this.radius = 5,
    this.startMargin = 0,
    this.endMargin = 0,
    this.topMargin = 0,
    this.bottomMargin = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<MyShimmer> createState() => _MyShimmerState();
}

class _MyShimmerState extends State<MyShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade300,
          Colors.grey.shade50,
          Colors.grey.shade300,
          Colors.grey.shade100,
        ],
      ),
      child: Container(
        height: widget.height.h,
        width: widget.width.w,
        margin: EdgeInsetsDirectional.only(
          start: widget.startMargin.w,
          end: widget.endMargin.w,
          top: widget.topMargin.h,
          bottom: widget.bottomMargin.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.radius.r),
        ),
      ),
    );
  }
}
