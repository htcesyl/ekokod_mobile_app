import 'package:ekokod_mobile_app/domain/entities/auth_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_auth_repository.dart';

import '../datasources/remote_auth_datasource.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final RemoteAuthDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<AuthEntity> login({
    required String email,
    required String password,
  }) async {
    final model = await remote.login(
      email: email,
      password: password,
    );
    return model.toEntity();
  }
}
