import 'package:app/controllers/style_controller.dart';
import 'package:app/extensions/opacity_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/styles_helper.dart';
import 'package:get/get.dart';

class MySearchField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final bool filled;

  const MySearchField({
    required this.controller,
    required this.onChanged,
    this.filled = false,
    this.onSubmitted,
    super.key,
  });

  @override
  State<MySearchField> createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> with StylesHelper {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StyleController>(
      builder: (styleC) {
        return Container(
          height: 40.h,
          decoration: BoxDecoration(
            boxShadow: widget.filled ? [appBoxShadow()] : null,
          ),
          child: TextField(
            onSubmitted: widget.onSubmitted,
            controller: widget.controller,
            onChanged: widget.onChanged,
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.changeOpacity(0.4),
                size: 20.w,
              ),
              hintText: 'search'.tr,
              hintStyle: TextStyle(
                color: const Color(0xff5D5D5D).changeOpacity(0.2),
                fontSize: 14.sp,
                height: 1.h,
              ),
              enabledBorder: buildOutlineInputBorder(
                const Color(0xff5D5D5D).changeOpacity(0.2),
              ),
              focusedBorder: buildOutlineInputBorder(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: widget.filled ? Colors.transparent : color,
        width: 1.w,
      ),
    );
  }
}
