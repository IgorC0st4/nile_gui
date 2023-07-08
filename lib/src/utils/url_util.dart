import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  void openUrlInExternalBrowser(String url) {
    launchUrl(Uri.parse(url));
  }
}
