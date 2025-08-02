import 'package:app/extensions/opacity_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin StylesHelper {
  BoxShadow appBoxShadow() {
    return BoxShadow(
      color: const Color(0xffE8E8F7).changeOpacity(.3),
      offset: const Offset(0, 3),
      // spreadRadius: 1.5,
      blurRadius: 14,
    );
  }

  List<BoxShadow> appElevation({double opacity = .07}) {
    return [
      BoxShadow(
        color: const Color(0xffEFA5AB).changeOpacity(opacity),
        offset: const Offset(0, -3),
        blurRadius: 16,
      ),
    ];
  }

  LinearGradient appLinearGradient({
    double opacity = 1,
    Axis axis = Axis.vertical,
    List<Color>? colors,
  }) {
    return LinearGradient(
      begin:
          axis == Axis.vertical
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.centerStart,
      end:
          axis == Axis.vertical
              ? AlignmentDirectional.bottomCenter
              : AlignmentDirectional.centerEnd,
      colors:
          colors ??
          [
            Get.theme.primaryColor.changeOpacity(opacity),
            Get.theme.colorScheme.secondary.changeOpacity(opacity),
          ],
    );
  }

  List<Color> get secondaryGradientColors => [
    const Color(0xffFDF3F6),
    const Color(0xffEEFBF5),
  ];

  Color convertHexadecimalStringToColor({required String hexadecimal}) {
    String newHexadecimal = hexadecimal.substring(1);
    int newIntHexadecimal = int.parse('0xff$newHexadecimal');
    Color colorToSend = Color(newIntHexadecimal);
    return colorToSend;
  }
}
