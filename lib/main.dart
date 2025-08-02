import 'package:app/consts/app_colors.dart';
import 'package:app/consts/app_consts.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/data_controller.dart';
import 'package:app/controllers/lang_controller.dart';
import 'package:app/controllers/style_controller.dart';
import 'package:app/consts/enums.dart';
import 'package:app/firebase/fb_notifications.dart';
import 'package:app/translations/app_translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:app/firebase_options.dart';
import 'package:app/screens/splash_screen.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/cache/cache_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Device Orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Shared Preferences
  await CacheController().init();

  /// Database
  // await DbSettings().initDatabase();

  /// Firebase
  try {
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await FbNotifications.initNotifications();
    FirebaseMessaging.instance.getToken().then((value) async {
      if (kDebugMode) {
        print('Fcm ==> $value');
      }
      await CacheController().setter(
        value: value ?? '',
        key: CacheKeys.fcmToken,
      );
    });
  } catch (e) {
    ///
  }
  SmsAutoFill().getAppSignature.then((value) async {
    if (kDebugMode) {
      print('App Signature ==> $value');
    }
    await CacheController().setter(value: value, key: CacheKeys.appSignature);
  });

  /// GetX
  Get.put(AuthController());
  Get.put(DataController());
  Get.put(LangController());
  Get.put(StyleController());

  /// App
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MyMaterialApp(),
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return GetBuilder<LangController>(
      builder: (langC) {
        return GetBuilder<StyleController>(
          builder: (styleC) {
            return GestureDetector(
              onTap: () {
                /// Remove keyboard on touching anywhere on the screen.
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: GetMaterialApp(
                theme: ThemeData(
                  fontFamily: AppConsts.appFontFamily,
                  primaryColor: AppColors.primary,
                  hintColor: const Color(0xff929292),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  dividerColor: Colors.grey.shade300,
                  colorScheme: theme.colorScheme.copyWith(
                    primary: AppColors.primary,
                    secondary: AppColors.secondary,
                  ),
                  scaffoldBackgroundColor: const Color(0xffF8F8F8),
                  shadowColor: Colors.grey.shade200,
                  textTheme: TextTheme(
                    titleMedium: _textStyle(),
                    bodyLarge: _textStyle(),
                    bodyMedium: _textStyle(),
                    bodySmall: _textStyle(),
                    displayLarge: _textStyle(),
                    displayMedium: _textStyle(),
                    displaySmall: _textStyle(),
                    headlineLarge: _textStyle(),
                    headlineMedium: _textStyle(),
                    headlineSmall: _textStyle(),
                    labelLarge: _textStyle(),
                    labelMedium: _textStyle(),
                    labelSmall: _textStyle(),
                    titleLarge: _textStyle(),
                    titleSmall: _textStyle(),
                  ),
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    },
                  ),
                ),
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
                supportedLocales:
                    AppLanguages.values
                        .map((language) => Locale(language.name))
                        .toList(),
                translations: AppTranslations(),
                fallbackLocale: Locale(AppConsts.defaultLanguage.name),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: Locale(langC.lang),
              ),
            );
          },
        );
      },
    );
  }

  TextStyle _textStyle() => TextStyle(
    color: const Color(0xff1C1C1C),
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    height: 1.h,
  );
}

/// https://secret@github.com/techzonesomhq/drively-mobile.git
/// git config user.name "alhissiimad"
/// git config user.email "alhissi.imad@gmail.com"
