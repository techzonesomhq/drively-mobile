import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/image_helper.dart';

typedef CounterCallBack = Function(String __);

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? prefixIcon;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final TextInputType inputType;
  final double topPadding;
  final double bottomPadding;
  final double horizontalPadding;
  final String? hint;
  final TextInputAction? inputAction;
  final Function(String)? onSubmitted;
  final int maxLines;
  final Function(String)? onChanged;
  final bool allowLetters;
  final Color? fillColor;
  final bool dottedBorder;
  final TextAlign textAlign;
  final bool showFocusBorder;
  final bool? obscure;
  final double? radius;
  final double endSuffixPadding;
  final CounterCallBack? counterCallBack;

  const MyTextField({
    this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.horizontalPadding = 0,
    this.hint,
    this.inputAction,
    this.onSubmitted,
    this.maxLines = 1,
    this.onChanged,
    this.allowLetters = true,
    this.fillColor,
    this.dottedBorder = false,
    this.textAlign = TextAlign.start,
    this.showFocusBorder = true,
    this.obscure,
    this.radius,
    this.endSuffixPadding = 20,
    this.counterCallBack,
    super.key,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> with ImageHelper {
  final FocusNode _focus = FocusNode();

  bool get _noLong => widget.maxLines == 1;

  final Color _grey = const Color(0xff5D5D5D).withOpacity(0.2);

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() => setState(() => focused = _focus.hasFocus);

  bool focused = false;

  late bool _obscure = widget.obscure ?? false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.bottomPadding.h,
        top: widget.topPadding.h,
        right: widget.horizontalPadding.w,
        left: widget.horizontalPadding.w,
      ),
      child: widget.dottedBorder
          ? DottedBorder(
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              color: focused ? Theme.of(context).primaryColor : _grey,
              strokeWidth: 1.w,
              radius: Radius.circular(_r.r),
              padding: EdgeInsets.zero,
              child: _body,
            )
          : _body,
    );
  }

  Widget get _body => SizedBox(
        height: _noLong ? 45.h : null,
        child: TextField(
          controller: widget.controller,
          focusNode: _focus,
          obscureText: _obscure,
          onChanged: widget.onChanged,
          cursorColor: Theme.of(context).primaryColor,
          cursorHeight: _noLong ? null : 0,
          textInputAction: widget.inputAction,
          onSubmitted: widget.onSubmitted,
          style: TextStyle(fontSize: 14.sp),
          keyboardType: widget.inputType,
          maxLines: widget.maxLines,
          inputFormatters: widget.allowLetters
              ? []
              : [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
                ],
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            filled: widget.fillColor != null,
            fillColor: widget.fillColor,
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: const Color(0xffA4B5B2),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              height: 1.h,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: appSvgImage('icons/${widget.prefixIcon}',
                        color: focused
                            ? Theme.of(context).primaryColor
                            : widget.prefixIconColor),
                  )
                : null,
            prefixIconConstraints:
                widget.prefixIcon != null ? null : const BoxConstraints(),
            suffixIconConstraints: const BoxConstraints(/*minWidth: 70.w*/),
            suffixIcon: Padding(
              padding:
                  EdgeInsetsDirectional.only(end: widget.endSuffixPadding.w),
              child: widget.obscure != null
                  ? _obscureSwitch
                  : _countChanger ?? widget.suffixIcon,
            ),
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? Theme.of(context).primaryColor
                    : const Color(0xffC9C9C9)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: _noLong ? 0 : 12.h),
            enabledBorder: _buildOutlineInputBorder(false),
            focusedBorder: _buildOutlineInputBorder(true),
          ),
        ),
      );

  Widget get _obscureSwitch {
    return InkWell(
      onTap: () => setState(() => _obscure = !_obscure),
      child: Icon(
        !_obscure ? Icons.visibility_off : Icons.visibility,
        size: 24.h,
      ),
    );
  }

  double get _r => widget.radius ?? (_noLong ? 12 : 20);

  OutlineInputBorder _buildOutlineInputBorder(bool active) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_r.r),
      borderSide: !widget.dottedBorder
          ? BorderSide(
              color: active && widget.showFocusBorder
                  ? Theme.of(context).primaryColor
                  : _grey,
              width: 1.w,
            )
          : BorderSide.none,
    );
  }

  Widget? get _countChanger {
    if (widget.counterCallBack == null) return null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _counterButton(true),
        SizedBox(height: 3.h),
        _counterButton(false),
      ],
    );
  }

  Widget _counterButton(bool plus) {
    if (widget.controller == null) return _empty;

    return InkWell(
      onTap: () {
        setState(() {
          int count = int.parse(widget.controller!.text);

          if (plus) {
            String __ = (++count).toString();
            widget.counterCallBack!(__);
          } else {
            if (count > 1) {
              String __ = (--count).toString();
              widget.counterCallBack!(__);
            }
          }
        });
      },
      child: Container(
        width: 18.w,
        height: 12.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Icon(
          plus ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          size: 14.w,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get _empty => const SizedBox.shrink();
}
