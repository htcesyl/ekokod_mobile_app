import 'package:ekokod_mobile_app/domain/entities/auth_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthEntity> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
