import 'package:app/controllers/auth_controller.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin NavigatorHelper {
  static Future<dynamic> jump({
    required Widget Function() to,
    bool replace = false,
    bool replaceAll = false,
    bool requiresAuth = false,
  }) async {
    var authC = Get.find<AuthController>();
    if (requiresAuth && !authC.loggedIn_) {
      ///
      dynamic x;
      return x;
    } else {
      if (!replace) {
        return await Get.to(to);
      } else {
        if (replaceAll) {
          return await Get.offAll(to);
        } else {
          return await Get.off(to, preventDuplicates: false);
        }
      }
    }
  }

  static Future<void> restartApp() async {
    jump(to: () => const SplashScreen(), replace: true, replaceAll: true);
  }
}
