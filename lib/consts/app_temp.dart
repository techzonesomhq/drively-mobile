class AppTemp {
  static const String tempString =
      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى';

  static String tempLongString({int length = 100}) {
    String text = '';

    for (int i = 1; i <= length; i++) {
      text += 'TEXT ';
    }
    return text;
  }

  static String get tempImage {
    String image =
        'https://c4.wallpaperflare.com/wallpaper/150/648/844/moon-purple-4k-8k-wallpaper-preview.jpg';
    return image;
  }
}

Future<void> get waitContext async =>
    await Future.delayed(const Duration(milliseconds: 50), () {});
