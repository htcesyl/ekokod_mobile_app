import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as fcm;

// Core / Network
import '../core/network/http_client.dart';
import '../core/network/network_info.dart';

// AUTH
import '../data/datasources/remote_auth_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/i_auth_repository.dart';
import '../domain/shared/login_usecase.dart';
import '../application/auth/auth_cubit.dart';

// NOTIFICATION
import '../data/datasources/notification_remote_data_source.dart';
import '../data/repositories/notification_repository_impl.dart';
import '../domain/repositories/notification_repository.dart';
import '../application/notification/notification_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ========= CORE / EXTERNAL =========

  // HTTP client
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // İnternet kontrolü
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // Ortak HttpClient (tüm remote data source'lar bunu kullanacak)
  sl.registerLazySingleton<HttpClient>(
    () => HttpClient(
      client: sl(),
      networkInfo: sl(),
    ),
  );

  // Firebase Messaging
  sl.registerLazySingleton<fcm.FirebaseMessaging>(
    () => fcm.FirebaseMessaging.instance,
  );

  // ========= AUTH =========

  // Data source
  sl.registerLazySingleton<RemoteAuthDataSource>(
    () => RemoteAuthDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Usecase
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );

  // Cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl(),
    ),
  );

  // ========= NOTIFICATION =========

  // Data source
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Cubit
  sl.registerFactory<NotificationCubit>(
    () => NotificationCubit(
      notificationRepository: sl(),
      firebaseMessaging: sl(),
    ),
  );

  // ========= DİĞER MODÜLLER İÇİN YER =========
  // Buraya ileride analytics, bills vb. için
  // datasource + repository + usecase + cubit kayıtlarını ekleyeceğiz.
}
