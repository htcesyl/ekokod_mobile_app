// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/router/app_router.dart';
import 'injections/injection_container.dart' as di;
import 'application/notification/notification_cubit.dart';
import 'application/auth/auth_cubit.dart';
import 'application/home/home_cubit.dart';

/// Uygulama arka plandayken gelen FCM mesajlarını yakalayan fonksiyon.
/// Top-level (dosyanın en üst seviyesinde) olmak zorunda.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase servislerini kullanacaksan tekrar init etmen gerekebilir.
  // (Şimdilik sadece log yazalım.)
  print('🔔 Arka planda bildirim geldi: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Firebase'i başlat
  await Firebase.initializeApp();

  // 2) Türkçe locale'i başlat (DateFormat için gerekli)
  await initializeDateFormatting('tr_TR', null);

  // 3) FCM arka plan mesaj handler'ını kaydet
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 4) Dependency Injection container'ı başlat (get_it)
  await di.init();

  // 5) Uygulamayı çalıştır
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Bildirimleri yönetecek Cubit'i tüm uygulamaya sağlıyoruz
        BlocProvider<NotificationCubit>(
          create: (_) => di.sl<NotificationCubit>(),
        ),
        // AuthCubit'i global olarak sağlıyoruz (login state'i korunur)
        // LazySingleton olarak kayıtlı olduğu için aynı instance kullanılır
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>(),
          lazy: false, // Hemen oluştur, state'i koru
        ),
        // HomeCubit'i global olarak sağlıyoruz (anasayfa verileri için)
        BlocProvider<HomeCubit>(
          create: (_) => di.sl<HomeCubit>(),
        ),
        // İleride başka Cubit/Bloc'ların varsa buraya ekleyebilirsin
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'EKOKOD',
      ),
    );
  }
}
