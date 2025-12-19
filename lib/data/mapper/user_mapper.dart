import 'package:ta_na_escola/domain/entities/user_entity.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

class UserMapper {
  static Map<String, dynamic> toMap({required UserEntity user}) {
    return <String, dynamic>{
      'id': user.id,
      'document': user.document,
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'token': user.token,
      'bornDate': user.bornDate,
      'tokenExpireAt': user.tokenExpireAt,
    };
  }

  static fromJson(Map<String, dynamic> data) {
    final bornDate = data['dados']['dataNascimento'] != null
        ? JackDateFormat.birthDayFormatter(data['dados']['dataNascimento'])
        : null;
    final tokenExpireAt = data['expiraEm'] != null
        ? DateTime.parse(data['expiraEm'])
        : null;
    return UserEntity(
      id: data['dados']['id'].toString(),
      document: data['dados']['cpf'].toString(),
      name: data['dados']['nome'].toString(),
      email: data['dados']['email'].toString(),
      image: data['dados']['imagem'],
      token: data['token'].toString(),
      bornDate: bornDate,
      tokenExpireAt: tokenExpireAt,
    );
  }
}
