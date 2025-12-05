import 'package:ekokod_mobile_app/domain/entities/auth_entity.dart';

abstract class IAuthRepository {
  Future<AuthEntity> login({
    required String email,
    required String password,
  });
}
