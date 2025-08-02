import 'package:app/cache/cache_controller.dart';
import 'package:app/consts/enums.dart';

mixin ApiHelper {
  final CacheController _cache = CacheController();

  Map<String, String> get httpHeaders {
    var headers = {
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'Accept-Language': _cache.getter(key: CacheKeys.language).toString(),
      'x-localization': _cache.getter(key: CacheKeys.language).toString(),
      'X-Client-Fcm-Token':
      _cache.getter(key: CacheKeys.fcmToken)?.toString() ?? '',
      'x-app-signature': _cache.getter(key: CacheKeys.appSignature).toString(),
    };
    if (_cache.getter(key: CacheKeys.loggedIn) == true) {
      headers['Authorization'] = _cache.getter(key: CacheKeys.token).toString();
    }
    return headers;
  }
}
