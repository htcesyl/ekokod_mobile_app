import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart' as fcm;

import '../data/datasources/notification_remote_data_source.dart';
import '../data/repositories/notification_repository_impl.dart';
import '../domain/repositories/notification_repository.dart';
import '../application/notification/notification_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ... daha önce register ettiğin her şey ...

  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<fcm.FirebaseMessaging>(() => fcm.FirebaseMessaging.instance);

  // Data sources
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remoteDataSource: sl()),
  );

  // Cubits
  sl.registerFactory<NotificationCubit>(
    () => NotificationCubit(
      notificationRepository: sl(),
      firebaseMessaging: sl(),
    ),
  );
}
