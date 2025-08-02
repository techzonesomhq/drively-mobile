import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/widgets/my_widgets/my_alert_button.dart';
import 'package:get/get.dart';

mixin AlertDialogsHelper {
  void appAlertDialog(
    BuildContext context, {
    required String title,
    bool barrierDismissible = true,
    bool showClose = true,
    String? filledText,
    Widget? up,
    required Function() filledAction,
    String? unfilledText,
    required Function() unfilledAction,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: [
                            showClose
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: Icon(
                                              Icons.close,
                                              size: 20.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  )
                                : _empty,
                            up ?? _empty,
                            Text(
                              title,
                              style: TextStyle(
                                color: const Color(0xff303030),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30.h),
                            Row(
                              children: [
                                MyAlertButton(
                                  text: filledText ?? 'yes'.tr,
                                  filled: true,
                                  action: filledAction,
                                ),
                                SizedBox(width: 20.w),
                                MyAlertButton(
                                  text: unfilledText ?? 'no'.tr,
                                  filled: false,
                                  action: unfilledAction,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void alertDialogTemplate(
    BuildContext context, {
    required Widget body,
    Clip clip = Clip.antiAlias,
    bool barrierDismissible = true,
    bool showClose = true,
    Function()? close,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          clipBehavior: clip,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    children: [
                      showClose
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap:
                                          close ?? () => Navigator.pop(context),
                                      child: Icon(
                                        Icons.close,
                                        size: 20.h,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                              ],
                            )
                          : _empty,
                      body,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void modalSheetTemplate(
    BuildContext context, {
    required Widget body,
    double topPadding = 15,
    double bottomPadding = 30,
    double hPadding = 30,
    bool expanded = true,
    bool scrollControlled = false,
    bool full = false,
    double radius = 25,
    bool notch = true,
    bool showClose = true,
    Function()? close,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: scrollControlled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
        ),
        side: BorderSide.none,
      ),
      builder: (context) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: scrollControlled && !full
              ? (MediaQuery.sizeOf(context).height / 1.2)
              : null,
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding.h,
              bottom: bottomPadding.h,
              right: hPadding.w,
              left: hPadding.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showClose
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: close ?? () => Navigator.pop(context),
                                child: Icon(
                                  Icons.close,
                                  size: 20.h,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                        ],
                      )
                    : _empty,
                notch
                    ? Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffECECEC),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      )
                    : _empty,
                expanded ? Expanded(child: body) : body,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _empty => const SizedBox.shrink();
}
