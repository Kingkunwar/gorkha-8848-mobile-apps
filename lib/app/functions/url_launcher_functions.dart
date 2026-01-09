import 'package:url_launcher/url_launcher.dart';

launchPhone(String phoneNumber) {
  Uri url = Uri.parse("tel:$phoneNumber");
  launchUrl(url);
}

launchEmail(String email) {
  Uri url = Uri(
    scheme: 'mailto',
    path: email,
  );
  launchUrl(url);
}
