import 'package:ekokod_mobile_app/domain/entities/alarm_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_alarm_repository.dart';

import '../datasources/remote_alarm_datasource.dart';

class AlarmRepositoryImpl implements IAlarmRepository {
  final RemoteAlarmDataSource remote;

  AlarmRepositoryImpl(this.remote);

  @override
  Future<List<AlarmEntity>> getAlarms() async {
    final models = await remote.getAlarms();
    return models.map((model) => model.toEntity()).toList();
  }
}

