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

// ALARM
import '../data/datasources/remote_alarm_datasource.dart';
import '../data/repositories/alarm_repository_impl.dart';
import '../domain/repositories/i_alarm_repository.dart';
import '../application/alarms/alarm_cubit.dart';

// BUILDING
import '../data/datasources/remote_building_datasource.dart';
import '../data/repositories/building_repository_impl.dart';
import '../domain/repositories/i_building_repository.dart';

// ANALYZER
import '../data/datasources/remote_analyzer_datasource.dart';
import '../data/repositories/analyzer_repository_impl.dart';
import '../domain/repositories/i_analyzer_repository.dart';

// CONSUMPTION
import '../data/datasources/remote_consumption_datasource.dart';
import '../data/repositories/consumption_repository_impl.dart';
import '../domain/repositories/i_consumption_repository.dart';

// PRODUCTION CONSUMPTION
import '../data/datasources/remote_production_consumption_datasource.dart';
import '../data/repositories/production_consumption_repository_impl.dart';
import '../domain/repositories/i_production_consumption_repository.dart';
import '../application/home/get_daily_production_consumption_usecase.dart';
import '../application/home/home_cubit.dart';
import '../application/analytics/analytics_cubit.dart';

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

  // ========= ALARM =========

  // Data source
  sl.registerLazySingleton<RemoteAlarmDataSource>(
    () => RemoteAlarmDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<IAlarmRepository>(
    () => AlarmRepositoryImpl(sl()),
  );

  // Cubit
  sl.registerFactory<AlarmCubit>(
    () => AlarmCubit(
      alarmRepository: sl(),
    ),
  );

  // ========= BUILDING =========

  // Data source
  sl.registerLazySingleton<RemoteBuildingDataSource>(
    () => RemoteBuildingDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<IBuildingRepository>(
    () => BuildingRepositoryImpl(sl()),
  );

  // ========= ANALYZER =========

  // Data source
  sl.registerLazySingleton<RemoteAnalyzerDataSource>(
    () => RemoteAnalyzerDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<IAnalyzerRepository>(
    () => AnalyzerRepositoryImpl(sl()),
  );

  // ========= CONSUMPTION =========

  // Data source
  sl.registerLazySingleton<RemoteConsumptionDataSource>(
    () => RemoteConsumptionDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<IConsumptionRepository>(
    () => ConsumptionRepositoryImpl(sl()),
  );

  // ========= PRODUCTION CONSUMPTION =========

  // Data source
  sl.registerLazySingleton<RemoteProductionConsumptionDataSource>(
    () => RemoteProductionConsumptionDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<IProductionConsumptionRepository>(
    () => ProductionConsumptionRepositoryImpl(sl()),
  );

  // Usecase
  sl.registerLazySingleton<GetDailyProductionConsumptionUseCase>(
    () => GetDailyProductionConsumptionUseCase(sl()),
  );

  // Cubit
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(
      getDailyProductionConsumptionUseCase: sl(),
      buildingRepository: sl(),
      analyzerRepository: sl(),
      consumptionRepository: sl(),
    ),
  );

  // ========= ANALYTICS =========

  // Cubit
  sl.registerFactory<AnalyticsCubit>(
    () => AnalyticsCubit(
      buildingRepository: sl(),
      analyzerRepository: sl(),
      consumptionRepository: sl(),
    ),
  );
}
