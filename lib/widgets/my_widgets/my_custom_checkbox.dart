import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CheckboxCallBack = Function(bool _);

class CustomCheckbox extends StatefulWidget {
  final bool status;
  final CheckboxCallBack callBack;
  final double size;

  const CustomCheckbox({
    required this.status,
    required this.callBack,
    this.size = 14,
    super.key,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.callBack(!widget.status),
      child: Container(
        height: widget.size.h,
        width: widget.size.h,
        padding: EdgeInsets.all(1.5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          border: Border.all(
            color: widget.status
                ? Theme.of(context).primaryColor
                : const Color(0xffEAECEE),
            width: 1.w,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.status ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }
}
