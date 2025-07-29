//import 'package:url_launcher/url_launcher.dart';

class LaunchUrlService {
  static void openUrl(Uri url, bool inSelf) {
    try {
      //launchUrl(url, webOnlyWindowName: (inSelf) ? '_self' : '_blank');
    } catch (e) {
      throw 'No se pudo iniciar ${url.toString()}';
    }
  }
}
