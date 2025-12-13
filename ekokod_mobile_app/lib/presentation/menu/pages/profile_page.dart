import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_themes.dart';
import '../../../core/constants/routes.dart';
import '../../../application/auth/auth_cubit.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/main_bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Bilgi öğesi widget'ı (modern ve düzenli tasarım)
  Widget _buildInfoItem({
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              height: 1.4,
            ),
          ),
          if (!isLast)
            Divider(height: 32, thickness: 1, color: Colors.grey[200]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sayfa Arkaplan Gradyanı
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Kullanıcı bilgilerini AuthState'ten al
        String userName = 'Kullanıcı';
        String? userPhone;
        String? companyId;

        if (state is AuthAuthenticated) {
          userName = state.user.userName;
          userPhone = state.user.phone;
          companyId = state.user.company;
        }

        // Varsayılan değerler (backend'den gelmeyen bilgiler için)
        const String userEmail =
            'email@example.com'; // TODO: Backend'den email eklenmeli
        final String firmName =
            companyId != null
                ? 'Firma ID: $companyId'
                : 'Firma Adı'; // TODO: Company bilgisinden çekilmeli
        const String firmTaxId =
            'Vergi No'; // TODO: Company bilgisinden çekilmeli
        const String userBuilding =
            'Tesis Adı'; // TODO: Company bilgisinden çekilmeli

        return Container(
          decoration: const BoxDecoration(
            // Menü sayfasında kullandığımız gradyan
            gradient: secondBackgroundGradient,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,

            // Custom AppBar
            // NOT: AppBar'da geri butonu olmaması için custom widget kullandık.
            appBar: const CustomAppBar(weatherData: '21°C'),

            // Bottom Navigation Bar
            bottomNavigationBar: const MainBottomNavBar(
              selectedIndex: 4, // Menü Sayfası indeksi
            ),

            // Sayfa İçeriği
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // ------------------------------------
                  // PROFILE HEADER SECTION
                  // ------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                    child: Column(
                      children: [
                        // Back Button
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.goNamed(RouteNames.menu);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.black,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Geri',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Profile Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.webColor,
                                AppColors.webColor.withOpacity(0.7),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.webColor.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // User Name
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // User Email
                        Text(
                          userEmail,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ------------------------------------
                  // CONTENT CARDS
                  // ------------------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // ------------------------------------
                        // 1. KULLANICI BİLGİLERİ KARTI
                        // ------------------------------------
                        Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.webColor.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.person_outline,
                                      color: AppColors.webColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Kişisel Bilgiler',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildInfoItem(
                                label: 'İsim Soyisim',
                                value: userName,
                              ),
                              _buildInfoItem(
                                label: 'E-Posta',
                                value: userEmail,
                              ),
                              _buildInfoItem(
                                label: 'Telefon Numarası',
                                value: userPhone ?? 'Belirtilmemiş',
                                isLast: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ------------------------------------
                        // 2. FİRMA VE TESİS BİLGİLERİ KARTI
                        // ------------------------------------
                        Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.webColor.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.business_outlined,
                                      color: AppColors.webColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Firma ve Tesis Bilgileri',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildInfoItem(
                                label: 'Firma Adı',
                                value: firmName,
                              ),
                              _buildInfoItem(
                                label: 'Vergi Numarası',
                                value: firmTaxId,
                              ),
                              _buildInfoItem(
                                label: 'Tesis (Bina) Adı',
                                value: userBuilding,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
