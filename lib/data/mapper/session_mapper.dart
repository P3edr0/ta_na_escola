import '../../domain/entities/session_entity.dart';

class SessionMapper {
  static Map<String, dynamic> toJson(SessionEntity data) {
    return {
      'credential': data.credential,
      'passWord': data.password,
      'image': data.image,
    };
  }

  static SessionEntity fromJson(Map<String, dynamic> data) {
    final String? image;
    if (data['image'] == null || data['image'] == 'null') {
      image = null;
    } else {
      image = data['image'];
    }
    return SessionEntity(
      credential: data['credential'],
      password: data['password'],
      image: image,
    );
  }
}
