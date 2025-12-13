import 'package:ekokod_mobile_app/domain/entities/auth_entity.dart';

class LoginModel {
  final String token;
  final String userName;
  final String? phone;
  final String? company;
  final String? userType;

  LoginModel({
    required this.token,
    required this.userName,
    this.phone,
    this.company,
    this.userType,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] as String,
      userName: json['userName'] as String,
      phone: json['phone'] as String?,
      company: json['company'] as String?,
      userType: json['userType'] as String?,
    );
  }

  AuthEntity toEntity() => AuthEntity(
        token: token,
        userName: userName,
        phone: phone,
        company: company,
        userType: userType,
      );
}
