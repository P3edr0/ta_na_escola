class CheckCredentialResponseEntity {
  final String id;
  final String changePasswordToken;
  final String profile;
  final String birthDay;
  final bool hasPassword;
  final bool hasFaceId;
  CheckCredentialResponseEntity({
    required this.id,
    required this.changePasswordToken,
    required this.hasPassword,
    required this.hasFaceId,
    required this.profile,
    required this.birthDay,
  });
}
