import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/i_alarm_repository.dart';
import '../../domain/entities/alarm_entity.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final IAlarmRepository alarmRepository;

  AlarmCubit({required this.alarmRepository}) : super(const AlarmInitial());

  /// Alarmları veritabanından çeker
  Future<void> fetchAlarms() async {
    emit(const AlarmLoading());

    try {
      final alarms = await alarmRepository.getAlarms();
      emit(AlarmLoaded(alarms: alarms));
    } catch (e, st) {
      print('❌ Alarm çekme hatası: $e');
      print(st);
      emit(AlarmError(message: e.toString()));
    }
  }
}

