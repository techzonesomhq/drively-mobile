import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBarWithShadow extends StatelessWidget {
  final Widget body;
  final double horizontalPadding;
  final bool top;
  final double topPadding;
  final double bottomPadding;
  final bool filled;

  const CustomBottomNavBarWithShadow({
    required this.body,
    this.horizontalPadding = 60,
    this.top = true,
    this.topPadding = 20,
    this.bottomPadding = 20,
    this.filled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: horizontalPadding.w,
        left: horizontalPadding.w,
        top: topPadding.h,
        bottom: bottomPadding.h,
      ),
      decoration: filled
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffEAF2FD).withOpacity(.35),
                  offset: top ? const Offset(0, -8) : const Offset(8, 0),
                  blurRadius: 13,
                ),
              ],
            )
          : null,
      child: body,
    );
  }
}
