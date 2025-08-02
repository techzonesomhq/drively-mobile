import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyActionContainer extends StatefulWidget {
  final Function()? action;
  final String? hint;
  final String? text;
  final double horizontalMargin;
  final double bottomMargin;
  final Color? fillColor;
  final double radius;
  final Widget? suffix;
  final bool border;
  final Color? textColor;
  final Widget? body;
  final double? height;
  final bool arrow;

  const MyActionContainer({
    this.action,
    this.hint,
    this.text,
    this.horizontalMargin = 0,
    this.bottomMargin = 0,
    this.fillColor,
    this.radius = 12,
    this.suffix,
    this.border = true,
    this.textColor,
    this.body,
    this.height = 45,
    this.arrow = false,
    super.key,
  });

  @override
  State<MyActionContainer> createState() => _MyActionContainerState();
}

class _MyActionContainerState extends State<MyActionContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.action,
      child: Container(
        height: widget.height != null ? widget.height!.h : widget.height,
        width: double.infinity,
        padding: widget.body == null
            ? EdgeInsetsDirectional.only(
                start: 18.w,
                end: 12.w,
              )
            : null,
        margin: EdgeInsets.only(
          right: widget.horizontalMargin.w,
          left: widget.horizontalMargin.w,
          bottom: widget.bottomMargin.h,
        ),
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(widget.radius.r),
          border: widget.border
              ? Border.all(
                  color: const Color(0xffE1E1E1),
                  width: 1.w,
                )
              : null,
        ),
        child: widget.body ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text ?? widget.hint ?? '',
                  style: TextStyle(
                      color: widget.textColor ??
                          (widget.text == null ? Colors.grey : null)),
                ),
                widget.suffix ?? _arrow ?? _empty,
              ],
            ),
      ),
    );
  }

  Widget? get _arrow => widget.arrow
      ? Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black45,
          size: 20.h,
        )
      : _empty;

  Widget get _empty => const SizedBox.shrink();
}
