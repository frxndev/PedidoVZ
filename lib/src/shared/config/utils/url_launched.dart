import 'package:url_launcher/url_launcher.dart';

void openUrl({String url = 'https://flutter.dev'}) async {
  final Uri url0 = Uri.parse(url);

  if (!await canLaunchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }

  await launchUrl(url0);
}
