import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

mixin ImageHelper {
  Widget appSvgImage(
    String path, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholderBuilder,
    bool network = false,
    double opacity = 1,
  }) {
    /// Path => folder/name
    return Opacity(
      opacity: opacity,
      child: !network
          ? SvgPicture.asset(
        path,
              width: width,
              height: height,
              color: color,
              // colorFilter: color != null
              //     ? ColorFilter.mode(
              //         color,
              //         BlendMode.srcIn,
              //       )
              //     : null,
              fit: fit,
            )
          : SvgPicture.network(
              path,
              width: width,
              height: height,
              color: color,
              fit: fit,
            ),
    );
  }

  Widget appCachedImage(
    String? image, {
    double? width = double.infinity,
    double? height,
    Color? color,
  }) {
    return CachedNetworkImage(
      imageUrl: image ?? '',
      width: width,
      fit: BoxFit.cover,
      height: height,
      color: color,
      errorWidget: (c, url, error) => errorImageBuilder,
    );
  }

  Widget get errorImageBuilder {
    return Padding(
      padding: EdgeInsets.all(6.h),
      child: appSvgImage(
        appLogo(),
        fit: BoxFit.cover,
        // color: Colors.black,
      ),
    );
  }

  String appLogo() => 'assets/images/app_bar_logo.svg';
}
