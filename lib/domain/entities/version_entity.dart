class VersionEntity {
  VersionEntity({
    required this.androidVersion,
    required this.iosVersion,
    required this.updateAndroidUrl,
    required this.updateIosUrl,
  });

  String androidVersion;
  String iosVersion;
  String updateAndroidUrl;
  String updateIosUrl;
}
