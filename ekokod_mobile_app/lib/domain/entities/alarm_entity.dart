// lib/domain/entities/alarm_entity.dart

class AlarmEntity {
  final String id;
  final String name;
  final String type;
  final List<String> analyzerIds;
  final List<AlarmLog> logs;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AlarmEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.analyzerIds,
    required this.logs,
    required this.createdAt,
    required this.updatedAt,
  });

  AlarmEntity copyWith({
    String? id,
    String? name,
    String? type,
    List<String>? analyzerIds,
    List<AlarmLog>? logs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AlarmEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      analyzerIds: analyzerIds ?? this.analyzerIds,
      logs: logs ?? this.logs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'AlarmEntity(id: $id, name: $name, type: $type, logs: ${logs.length})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlarmEntity &&
        other.id == id &&
        other.name == name &&
        other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}

class AlarmLog {
  final String id;
  final DateTime timestamp;
  final String message;
  final String details;

  const AlarmLog({
    required this.id,
    required this.timestamp,
    required this.message,
    required this.details,
  });

  AlarmLog copyWith({
    String? id,
    DateTime? timestamp,
    String? message,
    String? details,
  }) {
    return AlarmLog(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      message: message ?? this.message,
      details: details ?? this.details,
    );
  }

  @override
  String toString() =>
      'AlarmLog(id: $id, timestamp: $timestamp, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlarmLog && other.id == id && other.timestamp == timestamp;
  }

  @override
  int get hashCode => id.hashCode ^ timestamp.hashCode;
}
