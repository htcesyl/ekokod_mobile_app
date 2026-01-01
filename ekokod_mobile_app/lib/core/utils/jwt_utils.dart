import 'dart:convert';

/// JWT token işlemleri için utility sınıfı
class JwtUtils {
  /// JWT token'dan userId'yi çıkarır
  /// Token formatı: header.payload.signature
  /// Payload base64 encoded JSON'dur ve içinde userId bulunur
  static String? getUserIdFromToken(String token) {
    try {
      // JWT token 3 parçadan oluşur: header.payload.signature
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      // Payload'ı decode et (ikinci parça)
      final payload = parts[1];
      
      // Base64 URL decode (padding ekle gerekirse)
      String normalizedPayload = payload;
      // Base64 padding ekle (4'ün katı olmalı)
      final remainder = normalizedPayload.length % 4;
      if (remainder > 0) {
        normalizedPayload += '=' * (4 - remainder);
      }

      // Base64 URL decode için özel karakterleri düzelt
      normalizedPayload = normalizedPayload.replaceAll('-', '+').replaceAll('_', '/');
      
      final decodedBytes = base64Decode(normalizedPayload);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = jsonDecode(decodedString) as Map<String, dynamic>;

      // userId'yi al
      return payloadMap['userId'] as String?;
    } catch (e) {
      print('⚠️ JWT token decode hatası: $e');
      return null;
    }
  }
}
