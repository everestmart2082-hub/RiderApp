import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String address) async {
  final uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}");

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not open map';
  }
}
