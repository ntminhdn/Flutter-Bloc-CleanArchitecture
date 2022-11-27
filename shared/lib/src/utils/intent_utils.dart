import 'package:url_launcher/url_launcher.dart';

class IntentUtils {
  static Future<bool> openBrowserURL({
    required String url,
    bool inApp = false,
  }) async {
    return await canLaunch(url)
        ? await launch(url, forceSafariVC: inApp, forceWebView: inApp, enableJavaScript: true)
        : false;
  }
}
