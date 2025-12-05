import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/shared/login_usecase.dart';
import '../../domain/entities/auth_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(const AuthInitial());

  /// Email + şifre ile giriş denemesi yapar.
  /// - Loading state: [AuthLoading]
  /// - Başarılı: [AuthAuthenticated]
  /// - Hatalı: [AuthError]
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Debug log
    print('👉 AuthCubit.login çağrıldı: $email / $password');

    emit(const AuthLoading());

    try {
      final AuthEntity user = await loginUseCase(
        email: email,
        password: password,
      );

      // Başarılı login log’u
      print('✅ Login başarılı. Token: ${user.token}');

      emit(AuthAuthenticated(user: user));
    } catch (e, st) {
      // Hata log’u
      print('❌ Login sırasında hata: $e');
      print(st);

      emit(AuthError(message: e.toString()));
    }
  }

  /// Kullanıcıyı çıkış yapmış kabul eder, state'i ilk hâline döndürür.
  void logout() {
    print('🔁 AuthCubit.logout çağrıldı');
    emit(const AuthInitial());
  }
}
