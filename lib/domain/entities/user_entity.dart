class UserEntity {
  final String id;
  final String document;
  final String name;
  final String email;
  final String? image;
  final String token;
  final DateTime? bornDate;
  final DateTime? tokenExpireAt;
  UserEntity({
    required this.id,
    required this.document,
    required this.name,
    required this.email,
    required this.image,
    required this.token,
    this.bornDate,
    this.tokenExpireAt,
  });

  UserEntity copyWith({
    String? id,
    String? document,
    String? name,
    String? email,
    String? image,
    String? token,
    DateTime? bornDate,
    DateTime? tokenExpireAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      document: document ?? this.document,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      token: token ?? this.token,
      bornDate: bornDate ?? this.bornDate,
      tokenExpireAt: tokenExpireAt ?? this.tokenExpireAt,
    );
  }
}
