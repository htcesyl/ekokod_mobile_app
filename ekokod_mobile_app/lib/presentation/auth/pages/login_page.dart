import 'package:ekokod_mobile_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Klavye açılınca ekran yüksekliği küçülsün (AndroidManifest'te adjustResize de var)
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // --- Arka plan: klavyeden bağımsız, tam ekran ---
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: appBackgroundGradient),
            ),
          ),

          // --- İçerik: sadece yatay padding, klavye için extra bottom padding YOK ---
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // adjustResize ile constraints.maxHeight klavye açılınca küçülür
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                            //color: AppColors.white,
                            //colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 50),
                        const _LoginCard(),
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
  }
}

// *** Özel Widget: _LoginCard ***
class _LoginCard extends StatefulWidget {
  const _LoginCard();

  @override
  State<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> {
  // 3. Form verilerini tutmak için Controller'lar
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
              color: AppColors.darkGreen, // En koyu yeşili kullanabiliriz
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
                  color: AppColors.mediumGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Giriş Yap Butonu
          ElevatedButton(
            onPressed: () {
              // TODO: Giriş Yap Cubit/Command Tetikleme İşlemi buraya gelecek
              final email = _emailController.text;
              final password = _passwordController.text;
              debugPrint('Giriş Denemesi: $email / $password');
              // Navigator.of(context).pushReplacementNamed(Routes.homeRoute); // Başarılıysa yönlendirme
              context.goNamed(RouteNames.home); //geçici yönlendirme
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightGreen, // Yeşil buton rengi
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
            ),
            child: const Text(
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
