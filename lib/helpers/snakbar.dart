import 'package:app/consts/app_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

mixin SnackBarHelper {
  Future<void> showSnackBar({
    required String message,
    required bool error,
    int duration = 2,
  }) async {
    await waitContext;
    Get.snackbar(
      '',
      '',
      duration: Duration(seconds: duration),
      backgroundColor:
          error ? const Color(0xffff4d4f) : const Color(0xff52c41a),
      titleText: const SizedBox.shrink(),
      // snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        message.replaceAll('Exception: ', ''),
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
