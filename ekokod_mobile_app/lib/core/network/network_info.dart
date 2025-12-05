import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Ağ bağlantısı bilgisini soyutlayan interface
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Gerçek implementasyon: InternetConnectionChecker kullanır
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
