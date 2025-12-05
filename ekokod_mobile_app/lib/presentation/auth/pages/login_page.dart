import 'package:ekokod_mobile_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_themes.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/routes.dart';
import '../../../application/auth/auth_cubit.dart';
import '../../../injections/injection_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // AuthCubit'i DI üzerinden alıyoruz
      create: (_) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // ✅ Sadece backend başarılı login dönerse home'a git
            context.goNamed(RouteNames.home);
          } else if (state is AuthError) {
            // ❌ Hata varsa kullanıcıya göster
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            // Klavye açılınca ekran yüksekliği küçülsün
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                // --- Arka plan: klavyeden bağımsız, tam ekran ---
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: appBackgroundGradient),
                  ),
                ),

                // --- İçerik ---
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // adjustResize ile constraints.maxHeight klavye açılınca küçülür
                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 80),
                              Center(
                                child: Image.asset(
                                  AppAssets.logo,
                                  height: 96,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 50),
                              _LoginCard(isLoading: isLoading),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// *** Özel Widget: _LoginCard ***
class _LoginCard extends StatefulWidget {
  final bool isLoading;

  const _LoginCard({required this.isLoading});

  @override
  State<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> {
  // Form verilerini tutmak için Controller'lar
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground, // app_themes.dart'tan gelen açık renk
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // "GİRİŞ YAP" Başlığı
          const Text(
            'GİRİŞ YAP',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen, // En koyu yeşil
            ),
          ),
          const SizedBox(height: 30),

          // E-Posta Alanı
          _buildTextField(
            controller: _emailController,
            hintText: 'E-Posta',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Şifre Alanı
          _buildTextField(
            controller: _passwordController,
            hintText: 'Şifre',
            isPassword: true,
          ),
          const SizedBox(height: 10),

          // Şifremi Unuttum Butonu
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Şifremi Unuttum İşlemi (Pop-up veya yeni sayfa)
                debugPrint('Şifremi Unuttum Tıklandı');
              },
              child: const Text(
                'Şifremi Unuttum',
                style: TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Giriş Yap Butonu
          ElevatedButton(
            onPressed: widget.isLoading
                ? null
                : () {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();

                    // 1) Basit validasyon
                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('E-posta ve şifre alanları boş olamaz.'),
                        ),
                      );
                      return;
                    }

                    if (!email.contains('@')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Geçerli bir e-posta adresi girin.'),
                        ),
                      );
                      return;
                    }

                    // Debug
                    debugPrint('Giriş Denemesi: $email / $password');

                    // 2) Artık direkt home'a gitmek YOK → önce cubit üzerinden backend'e isteği at
                    context.read<AuthCubit>().login(
                          email: email,
                          password: password,
                        );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.webColor, // Yeşil buton rengi
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(41),
              ),
              elevation: 5,
            ),
            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : const Text(
                    'Giriş Yap',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Ortak TextField Oluşturma Fonksiyonu
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppColors.white, // TextField arkaplanı beyaz
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
