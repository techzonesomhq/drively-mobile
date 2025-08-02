import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/image_helper.dart';

class NoData extends StatefulWidget {
  final String? text;
  final String? icon;
  final double? iconHeight;
  final double? fontSize;

  const NoData({
    this.text,
    this.icon,
    this.iconHeight,
    this.fontSize,
    super.key,
  });

  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> with ImageHelper {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        appSvgImage(
          'icons/${widget.icon ?? 'default_icon'}',
          height: (widget.iconHeight ?? 50).h,
          color: Colors.grey,
        ),
        SizedBox(height: 20.h),
        Text(
          widget.text ?? 'noData'.tr,
          style: TextStyle(
            color: Colors.grey,
            fontSize: (widget.fontSize ?? 18).sp,
          ),
        ),
      ],
    );
  }
}
