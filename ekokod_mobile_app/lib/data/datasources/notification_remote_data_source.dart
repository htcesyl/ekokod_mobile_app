import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants/api_endpoints.dart';

abstract class NotificationRemoteDataSource {
  Future<void> saveDeviceToken({
    required String userId,
    required String fcmToken,
    required String platform,
  });

  Future<void> deleteDeviceToken({
    required String userId,
    required String fcmToken,
  });
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final http.Client client;

  NotificationRemoteDataSourceImpl(this.client);

  @override
  Future<void> saveDeviceToken({
    required String userId,
    required String fcmToken,
    required String platform,
  }) async {
    final url = Uri.parse(ApiEndpoints.saveDeviceToken);
    final requestBody = {
      'userId': userId,
      'fcmToken': fcmToken,
      'platform': platform,
    };
    
    print('🔗 Device token kaydetme isteği:');
    print('   URL: $url');
    print('   Body: $requestBody');
    
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print('📥 Device token kaydetme yanıtı:');
    print('   Status Code: ${response.statusCode}');
    print('   Body: ${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Device token kaydedilemedi: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteDeviceToken({
    required String userId,
    required String fcmToken,
  }) async {
    final url = Uri.parse(ApiEndpoints.deleteDeviceToken);
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'fcmToken': fcmToken,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Device token silinemedi: ${response.statusCode}');
    }
  }
}
