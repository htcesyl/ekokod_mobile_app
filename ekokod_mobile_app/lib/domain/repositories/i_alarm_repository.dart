import 'package:ekokod_mobile_app/domain/entities/alarm_entity.dart';

abstract class IAlarmRepository {
  Future<List<AlarmEntity>> getAlarms();
}

