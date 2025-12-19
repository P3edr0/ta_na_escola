enum CheckCredentialStatus {
  withoutAccount,
  withoutPassword,
  withoutFaceId,
  completeAccount;

  bool get isWithoutAccount => this == withoutAccount;
  bool get isWithoutPassword => this == withoutPassword;
  bool get isWithoutFaceId => this == withoutFaceId;
  bool get isCompleteAccount => this == completeAccount;
}
