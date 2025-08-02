import 'package:app/cache/cache_controller.dart';
import 'package:app/consts/enums.dart';
import 'package:get/get.dart';

class StyleController extends GetxController {
  /// Main Screen Index
  int _mainIndex = 0;

  int get index => _mainIndex;

  set index(int __) => [_mainIndex = __, update()];

  /// Theme
  int theme_ = CacheController().getter(key: CacheKeys.theme) ?? -1;

  Future<void> changeTheme_() async {
    theme_ = theme_ == 1 ? 0 : 1;
    await CacheController().setter(key: CacheKeys.theme, value: theme_);
    update();
  }
}
