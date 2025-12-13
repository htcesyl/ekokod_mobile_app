import 'package:ekokod_mobile_app/core/network/http_client.dart';
import 'package:ekokod_mobile_app/core/network/endpoints.dart';

import '../models/alarm_model.dart';

abstract class RemoteAlarmDataSource {
  Future<List<AlarmModel>> getAlarms();
}

class RemoteAlarmDataSourceImpl implements RemoteAlarmDataSource {
  final HttpClient httpClient;

  RemoteAlarmDataSourceImpl(this.httpClient);

  @override
  Future<List<AlarmModel>> getAlarms() async {
    final json = await httpClient.get(AlarmEndpoints.list);

    // JSON array olarak geliyorsa
    if (json is List) {
      return json
          .map((item) => AlarmModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    // Tek bir obje olarak geliyorsa (backend'den array dönmüyorsa)
    if (json is Map<String, dynamic>) {
      // Eğer 'data' veya 'alarms' key'i varsa
      if (json.containsKey('data')) {
        final data = json['data'] as List;
        return data
            .map((item) => AlarmModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      if (json.containsKey('alarms')) {
        final alarms = json['alarms'] as List;
        return alarms
            .map((item) => AlarmModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      // Tek alarm objesi olarak geliyorsa
      return [AlarmModel.fromJson(json)];
    }

    return [];
  }
}

