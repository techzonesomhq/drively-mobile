import 'package:app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/image_helper.dart';
import 'package:app/helpers/navigator_helper.dart';
import 'package:app/helpers/styles_helper.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MyListTile extends StatefulWidget {
  final String icon;
  final String leading;
  final bool trailingIcon;
  final Function()? onTap;
  final Color? itemColor;
  final bool requiresAuth;
  final bool assetIcon;
  final bool decoration;
  final bool divider;

  const MyListTile({
    required this.icon,
    required this.leading,
    this.trailingIcon = true,
    this.onTap,
    this.itemColor,
    this.requiresAuth = true,
    this.assetIcon = true,
    this.decoration = false,
    this.divider = true,
    super.key,
  });

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile>
    with NavigatorHelper, ImageHelper, StylesHelper {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authC) {
        return /*widget.requiresAuth && !auth.loggedIn_
            ? _empty
            :*/ InkWell(
          onTap: widget.onTap,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(
                  children: [
                    Container(
                      height: 32.h,
                      width: 32.h,
                      alignment: Alignment.center,
                      decoration:
                          widget.decoration
                              ? BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: appLinearGradient(

                                  colors: secondaryGradientColors,
                                ),
                              )
                              : null,
                      child: appSvgImage(
                        'icons/${widget.icon}',
                        color: widget.itemColor,
                        width: 17.w,
                        network: !widget.assetIcon,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      widget.leading,
                      style: TextStyle(
                        color: widget.itemColor,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    widget.trailingIcon
                        ? Icon(
                          Icons.arrow_forward_ios,
                          size: 14.w,
                          color: Colors.black,
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              widget.divider ? _divider : _empty,
            ],
          ),
        );
      },
    );
  }

  Widget get _empty => const SizedBox.shrink();

  Widget get _divider => Divider(height: 0.h);
}
