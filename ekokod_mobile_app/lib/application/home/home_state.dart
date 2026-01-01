// lib/application/home/home_state.dart
// Home sayfasının durumlarını(loading, error, success) için kullanılacak.

part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final DailyProductionConsumptionEntity data;
  final List<ChartPointEntity>? annualConsumptionData; // Yıllık tüketim verileri

  const HomeLoaded({
    required this.data,
    this.annualConsumptionData,
  });

  @override
  List<Object?> get props => [data, annualConsumptionData];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
