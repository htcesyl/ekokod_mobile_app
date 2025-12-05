import 'package:ekokod_mobile_app/core/network/http_client.dart';
import 'package:ekokod_mobile_app/core/network/endpoints.dart';

import '../models/login_model.dart';

abstract class RemoteAuthDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final HttpClient httpClient;

  RemoteAuthDataSourceImpl(this.httpClient);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final json = await httpClient.post(
      AuthEndpoints.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    return LoginModel.fromJson(json as Map<String, dynamic>);
  }
}
