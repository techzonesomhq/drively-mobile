import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app/cache/cache_controller.dart';
import 'package:app/consts/enums.dart';
import 'package:app/models/api/user/user_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  /// User
  UserModel? user_;

  Future<void> saveUser_(
      UserModel? user, {
        bool login = true,
        String? token,
      }) async {
    user_ = user;
    if (login && token != null) {
      await CacheController().setter(key: CacheKeys.token, value: token);
    }
    await login_;
    update();
  }

  /// Auth
  bool loggedIn_ = CacheController().getter(key: CacheKeys.loggedIn) ?? false;

  Future<void> get login_ async {
    loggedIn_ = true;
    await CacheController().setter(key: CacheKeys.loggedIn, value: true);
    update();
  }

  Future<void> get logout_ async {
    loggedIn_ = false;
    user_ = null;
    await FirebaseMessaging.instance.deleteToken();
    await CacheController().logout;
    update();
  }
}
