import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedContainer extends StatelessWidget {
  final double radius;
  final Widget child;

  const DottedContainer({
    this.radius = 15,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      color: Theme.of(context).hintColor.withOpacity(.2),
      strokeWidth: 1.w,
      radius: Radius.circular(radius.r),
      padding: EdgeInsets.zero,
      child: child,
    );
  }
}
