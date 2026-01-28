import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

import 'url_launcher_service.dart';

class UrlLauncherServiceImpl implements IUrlLauncherService {
  @override
  Future<bool> canLaunch(String url) async {
    try {
      final uri = _parseUrl(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> launchCurrentUrl(String url) async {
    return launchUrlWithMode(url, LaunchMode.platformDefault);
  }

  @override
  Future<bool> launchUrlWithMode(String url, LaunchMode mode) async {
    try {
      final uri = _parseUrl(url);

      if (!await canLaunchUrl(uri)) {
        log('Não é possível abrir esta URL: $url');
        return false;
      }

      final success = await launchUrl(uri);

      if (!success) {
        log('Falha ao abrir URL: $url');
        return false;
      }

      return success;
    } catch (e) {
      log('Erro ao abrir URL: ${e.toString()}');
      return false;
    }
  }

  Uri _parseUrl(String url) {
    // Adiciona protocolo se faltar
    String formattedUrl = url.trim();

    if (!formattedUrl.contains(RegExp(r'^https?://'))) {
      formattedUrl = 'https://$formattedUrl';
    }

    return Uri.parse(formattedUrl);
  }
}
