import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/styles_helper.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool loading;
  final double height;
  final double horizontalMargin;
  final double topMargin;
  final double bottomMargin;
  final double fontSize;
  final bool filled;
  final Object? icon;
  final double radius;
  final Color? fillColor;
  final FontWeight fontWeight;
  final Color? textColor;
  final double? width;
  final bool slider;

  const MyButton({
    required this.text,
    this.onTap,
    this.loading = false,
    this.height = 45,
    this.horizontalMargin = 0,
    this.topMargin = 0,
    this.bottomMargin = 0,
    this.fontSize = 15,
    this.filled = true,
    this.icon,
    this.radius = 12,
    this.fillColor,
    this.fontWeight = FontWeight.w500,
    this.textColor,
    this.width,
    this.slider = false,
    super.key,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> with StylesHelper {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.slider && !widget.loading ? widget.onTap : null,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: widget.height.h,
            width: widget.width == null ? double.infinity : widget.width!.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: widget.topMargin.h,
              bottom: widget.bottomMargin.h,
              right: widget.horizontalMargin.w,
              left: widget.horizontalMargin.w,
            ),
            decoration: BoxDecoration(
              color: widget.filled ? widget.fillColor : null,
              borderRadius: BorderRadius.circular(widget.radius.r),
              gradient: widget.filled && widget.fillColor == null
                  ? appLinearGradient(axis: Axis.horizontal)
                  : null,
              border: !widget.filled
                  ? Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.w,
                    )
                  : null,
            ),
            child: !widget.loading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIcon,
                      AnimatedOpacity(
                        opacity: _showText ? 1 : 0,
                        duration: 200.milliseconds,
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            color: widget.textColor ??
                                (widget.filled
                                    ? Colors.white
                                    : Theme.of(context).primaryColor),
                            fontSize: widget.fontSize.sp,
                            fontWeight: widget.fontWeight,
                            height: 1.h,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 30.h,
                    width: 30.h,
                    child: CircularProgressIndicator(
                        color: widget.filled
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                  ),
          ),
          _buildSliderArrow,
        ],
      ),
    );
  }

  GlobalKey key = GlobalKey();

  bool _showText = true;

  Widget get _buildSliderArrow {
    return widget.slider && !widget.loading
        ? PositionedDirectional(
            top: 5.h,
            bottom: 5.h,
            start: 50.w,
            end: 12.w,
            child: Dismissible(
              onUpdate: (details) =>
                  setState(() => _showText = !details.reached),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                await widget.onTap?.call();
                setState(() => _showText = true);
                return false;
              },
              key: key,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 32.w,
                    alignment: Alignment.center,
                    padding: EdgeInsetsDirectional.only(start: 4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 14.w,
                    ),
                  ),
                ],
              ),
            ),
          )
        : _empty;
  }

  // (widget.horizontalMargin + 12).w,

  Widget get _buildIcon {
    return widget.icon != null
        ? Row(
            children: [
              widget.icon is IconData
                  ? Icon(
                      widget.icon as IconData,
                      size: 20.h,
                      color: Theme.of(context).primaryColor,
                    )
                  : widget.icon as Widget,
              SizedBox(width: 6.w),
            ],
          )
        : _empty;
  }

  Widget get _empty => const SizedBox.shrink();
}
