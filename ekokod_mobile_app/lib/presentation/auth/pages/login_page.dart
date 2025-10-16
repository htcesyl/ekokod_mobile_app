import 'package:flutter/material.dart';

// Renk ve Gradyanları import edin
import '../../../core/constants/app_themes.dart';
// Rotaları import edin (Kullanılacaksa)
import '../../../core/router/app_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sayfanın iskeleti ve arkaplan gradyanı
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // appBackgroundGradient, app_themes.dart'ta tanımladığımız gradyan
          gradient: loginBackgroundGradient,
        ),
        // Klavye açıldığında taşmayı önler
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Uygulama başlığının üstündeki boşluk
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),

              // 1. "EKOKOD" Başlığı
              const Text(
                'EKOKOD',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 50),

              // 2. Giriş Kartı (Ana Widget)
              const _LoginCard(),

              // Giriş kartının altındaki boşluk
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
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
                print('Şifremi Unuttum Tıklandı');
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
              print('Giriş Denemesi: $email / $password');
              // Navigator.of(context).pushReplacementNamed(Routes.homeRoute); // Başarılıysa yönlendirme
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
          borderSide: BorderSide.none, // Kenarlık olmasın
        ),
      ),
    );
  }
}
