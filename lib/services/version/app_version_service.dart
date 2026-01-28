import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:ta_na_escola/domain/entities/version_entity.dart';

import '../../domain/usecases/services/version/get_version_usecase.dart';

class AppVersionService {
  AppVersionService({required this.getVersionUsecase});

  VersionEntity? latestVersion;

  String? appVersion;
  String? storeUrl;
  final GetVersionUsecase getVersionUsecase;
  bool? hasNewVersion;
  Future<void> _getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion = info.version;
  }

  Future<void> getLatestVersion() async {
    await _getAppVersion();
    final response = await getVersionUsecase();

    response.fold(
      (newException) {
        latestVersion = null;
      },
      (newVersion) {
        latestVersion = newVersion;
        _checkHasNewVersion();
      },
    );
  }

  _checkHasNewVersion() {
    if (appVersion == null || latestVersion == null) {
      hasNewVersion = null;
      return;
    }

    if (Platform.isAndroid) {
      if (appVersion != latestVersion!.androidVersion) {
        hasNewVersion = true;
      } else {
        hasNewVersion = false;
      }
      storeUrl = latestVersion!.updateAndroidUrl;
      return;
    }

    if (appVersion != latestVersion!.iosVersion) {
      hasNewVersion = true;
    } else {
      hasNewVersion = false;
    }
    storeUrl = latestVersion!.updateIosUrl;
    return;
  }
}
