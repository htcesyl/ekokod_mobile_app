// lib/domain/entities/auth_entity.dart

class AuthEntity {
  final String token;
  final String userName;
  final String? phone;
  final String? company;
  final String? userType;

  const AuthEntity({
    required this.token,
    required this.userName,
    this.phone,
    this.company,
    this.userType,
  });

  AuthEntity copyWith({
    String? token,
    String? userName,
    String? phone,
    String? company,
    String? userType,
  }) {
    return AuthEntity(
      token: token ?? this.token,
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      userType: userType ?? this.userType,
    );
  }

  @override
  String toString() =>
      'AuthEntity(token: $token, userName: $userName, phone: $phone, company: $company, userType: $userType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthEntity &&
        other.token == token &&
        other.userName == userName &&
        other.phone == phone &&
        other.company == company &&
        other.userType == userType;
  }

  @override
  int get hashCode =>
      token.hashCode ^
      userName.hashCode ^
      (phone?.hashCode ?? 0) ^
      (company?.hashCode ?? 0) ^
      (userType?.hashCode ?? 0);
}
