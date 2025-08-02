import 'package:app/consts/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static final CacheController _cache = CacheController._();

  CacheController._();

  late SharedPreferences _shared;

  factory CacheController() => _cache;

  Future<void> init() async => _shared = await SharedPreferences.getInstance();

  Future<void> setter({required CacheKeys key, required dynamic value}) async {
    if (value is String) {
      if (key == CacheKeys.token) {
        await _shared.setString(key.name, 'Bearer $value');
      } else {
        await _shared.setString(key.name, value);
      }
    } else if (value is int) {
      await _shared.setInt(key.name, value);
    } else if (value is bool) {
      await _shared.setBool(key.name, value);
    }
  }

  dynamic getter({required CacheKeys key}) => _shared.get(key.name);

  Future<void> get logout async {
    await _shared.setString(CacheKeys.token.name, '');
    await _shared.setString(CacheKeys.fcmToken.name, '');
    await _shared.setBool(CacheKeys.loggedIn.name, false);
  }
}
