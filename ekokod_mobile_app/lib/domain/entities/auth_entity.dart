// lib/domain/entities/auth_entity.dart

class AuthEntity {
  final String token;
  final String userName;

  // İstersen ileride userId, email, roles vs. ekleyebilirsin.

  const AuthEntity({
    required this.token,
    required this.userName,
  });

  AuthEntity copyWith({
    String? token,
    String? userName,
  }) {
    return AuthEntity(
      token: token ?? this.token,
      userName: userName ?? this.userName,
    );
  }

  @override
  String toString() => 'AuthEntity(token: $token, userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthEntity &&
        other.token == token &&
        other.userName == userName;
  }

  @override
  int get hashCode => token.hashCode ^ userName.hashCode;
}
