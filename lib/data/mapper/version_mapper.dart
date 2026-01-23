import 'package:ta_na_escola/domain/entities/version_entity.dart';

class VersionMapper {
  static VersionEntity fromJson(Map<String, dynamic> data) {
    return VersionEntity(
      iosVersion: data["versaoApple"].toString(),
      androidVersion: data["versaoAndroid"].toString(),
      updateAndroidUrl: data["urlAndroid"].toString(),
      updateIosUrl: data["urlApple"].toString(),
    );
  }
}
