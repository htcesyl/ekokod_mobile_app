// lib/application/alarms/alarm_state.dart

part of 'alarm_cubit.dart';

abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object?> get props => [];
}

class AlarmInitial extends AlarmState {
  const AlarmInitial();
}

class AlarmLoading extends AlarmState {
  const AlarmLoading();
}

class AlarmLoaded extends AlarmState {
  final List<AlarmEntity> alarms;

  const AlarmLoaded({required this.alarms});

  @override
  List<Object?> get props => [alarms];
}

class AlarmError extends AlarmState {
  final String message;

  const AlarmError({required this.message});

  @override
  List<Object?> get props => [message];
}

