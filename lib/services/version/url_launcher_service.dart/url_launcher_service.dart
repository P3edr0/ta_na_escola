import 'package:url_launcher/url_launcher_string.dart';

abstract class IUrlLauncherService {
  Future<bool> canLaunch(String url);
  Future<bool> launchCurrentUrl(String url);
  Future<bool> launchUrlWithMode(String url, LaunchMode mode);
}
