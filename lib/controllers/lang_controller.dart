import 'package:app/cache/cache_controller.dart';
import 'package:app/consts/app_consts.dart';
import 'package:get/get.dart';
import '../consts/enums.dart';

class LangController extends GetxController {
  String lang =
      CacheController().getter(key: CacheKeys.language) ??
      AppConsts.defaultLanguage.name;

  String languageName({AppLanguages? locale}) {
    String __ = locale?.name ?? lang;
    switch (__) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
    }

    return '';
  }

  bool appDirectionRtl = true;

  Future<void> changeLang(AppLanguages language) async {
    lang = language.name;
    switch (language) {
      case AppLanguages.ar:
        appDirectionRtl = true;
        break;
      case AppLanguages.en:
        appDirectionRtl = false;
        break;
    }
    await CacheController().setter(key: CacheKeys.language, value: lang);
    update();
  }

  Future<void> changeLangLocale(String language) async {
    lang = language;
    switch (language) {
      case 'ar':
        appDirectionRtl = true;
        break;
      case 'en':
        appDirectionRtl = false;
        break;
    }
    await CacheController().setter(key: CacheKeys.language, value: lang);
    update();
  }
}
