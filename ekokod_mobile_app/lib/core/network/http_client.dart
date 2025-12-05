
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'endpoints.dart';
import 'network_info.dart';


class HttpClient {
  final http.Client client;
  final NetworkInfo networkInfo;

  HttpClient({
    required this.client,
    required this.networkInfo,
  });

  /// GET isteği
  Future<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    await _checkConnection();

    final uri = Uri.parse('${ApiConfig.baseUrl}$path')
        .replace(queryParameters: queryParameters);
    final response = await client.get(uri, headers: headers);

    return _handleResponse(response);
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    await _checkConnection();

    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      },
      body: jsonEncode(body ?? {}),
    );

    return _handleResponse(response);
  }


  Future<void> _checkConnection() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw Exception('İnternet bağlantısı yok');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {

      throw Exception(
        'API error [${response.statusCode}]: ${response.body}',
      );
    }
  }
}
