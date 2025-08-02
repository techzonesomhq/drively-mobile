import 'package:app/consts/enums.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

mixin OutAppHelper {
  Future<void> launchThisUrl(
    String link, {
    LauncherType type = LauncherType.link,
  }) async {
    String __ = '';

    switch (type) {
      case LauncherType.link:
        __ = link;
        break;
      case LauncherType.mobile:
        __ = 'tel:$link';
        break;
      case LauncherType.email:
        __ = 'mailto:$link';
        break;
    }
    final Uri url = Uri.parse(__);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> shareThisUrl(String link, {String? subject}) async {
    await Share.share(link, subject: subject);
  }
}
