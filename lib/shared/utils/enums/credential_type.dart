enum CredentialType {
  document,
  email;

  bool get isDocument => this == document;
  bool get isEmail => this == email;

  @override
  String toString() {
    if (this == document) {
      return 'CPF';
    }
    return 'E-mail';
  }
}
