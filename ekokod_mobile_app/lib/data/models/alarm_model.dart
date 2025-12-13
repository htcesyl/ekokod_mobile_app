import 'package:ekokod_mobile_app/domain/entities/alarm_entity.dart';

class AlarmModel {
  final String id;
  final String name;
  final String type;
  final List<String> analyzerIds;
  final List<AlarmLogModel> logs;
  final DateTime createdAt;
  final DateTime updatedAt;

  AlarmModel({
    required this.id,
    required this.name,
    required this.type,
    required this.analyzerIds,
    required this.logs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    // _id field'ını string'e çevir
    final id =
        json['_id'] is Map
            ? (json['_id'] as Map)['\$oid'] as String? ?? json['_id'].toString()
            : json['_id'].toString();

    // analyzers array'ini string list'e çevir
    final analyzers = json['analyzers'] as List<dynamic>? ?? [];
    final analyzerIds =
        analyzers.map((analyzer) {
          if (analyzer is Map && analyzer.containsKey('\$oid')) {
            return analyzer['\$oid'] as String;
          }
          return analyzer.toString();
        }).toList();

    // logs array'ini parse et
    final logsJson = json['logs'] as List<dynamic>? ?? [];
    final logs =
        logsJson
            .map(
              (logJson) =>
                  AlarmLogModel.fromJson(logJson as Map<String, dynamic>),
            )
            .toList();

    // createdAt ve updatedAt parse et
    DateTime parseDate(dynamic dateValue) {
      if (dateValue == null) return DateTime.now();
      if (dateValue is Map && dateValue.containsKey('\$date')) {
        return DateTime.parse(dateValue['\$date'] as String).toLocal();
      }
      if (dateValue is String) {
        return DateTime.parse(dateValue).toLocal();
      }
      return DateTime.now();
    }

    return AlarmModel(
      id: id,
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      analyzerIds: analyzerIds,
      logs: logs,
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
    );
  }

  AlarmEntity toEntity() {
    return AlarmEntity(
      id: id,
      name: name,
      type: type,
      analyzerIds: analyzerIds,
      logs: logs.map((log) => log.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class AlarmLogModel {
  final String id;
  final DateTime timestamp;
  final String message;
  final String details;

  AlarmLogModel({
    required this.id,
    required this.timestamp,
    required this.message,
    required this.details,
  });

  factory AlarmLogModel.fromJson(Map<String, dynamic> json) {
    // _id field'ını string'e çevir
    final id =
        json['_id'] is Map
            ? (json['_id'] as Map)['\$oid'] as String? ?? json['_id'].toString()
            : json['_id'].toString();

    // timestamp parse et
    DateTime parseTimestamp(dynamic timestampValue) {
      if (timestampValue == null) return DateTime.now();
      if (timestampValue is Map && timestampValue.containsKey('\$date')) {
        return DateTime.parse(timestampValue['\$date'] as String).toLocal();
      }
      if (timestampValue is String) {
        return DateTime.parse(timestampValue).toLocal();
      }
      return DateTime.now();
    }

    return AlarmLogModel(
      id: id,
      timestamp: parseTimestamp(json['timestamp']),
      message: json['message'] as String? ?? '',
      details: json['details'] as String? ?? '',
    );
  }

  AlarmLog toEntity() {
    return AlarmLog(
      id: id,
      timestamp: timestamp,
      message: message,
      details: details,
    );
  }
}
