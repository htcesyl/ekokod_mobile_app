import 'package:ekokod_mobile_app/domain/entities/auth_entity.dart';

class LoginModel {
  final String token;
  final String userName;

  // İstersen buraya refreshToken, roles vs. ekleyebilirsin

  LoginModel({
    required this.token,
    required this.userName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] as String,
      userName: json['userName'] as String,
    );
  }

  AuthEntity toEntity() => AuthEntity(
        token: token,
        userName: userName,
      );
}
