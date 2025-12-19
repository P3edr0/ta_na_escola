import '../../domain/entities/check_credential_response_entity.dart';

class CredentialResponseMapper {
  static CheckCredentialResponseEntity fromJson(Map<String, dynamic> data) {
    return CheckCredentialResponseEntity(
      id: data["idPessoa"].toString(),
      hasFaceId: data["fotoCadastrada"],
      hasPassword: data["senhaCadastrada"],
      profile: data["perfil"].toString(),
      birthDay: data["dataNascimento"].toString(),
      changePasswordToken: data["tokenAlteracaoSenha"] ?? '',
    );
  }

  Map<String, dynamic> toJson(CheckCredentialResponseEntity user) {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
