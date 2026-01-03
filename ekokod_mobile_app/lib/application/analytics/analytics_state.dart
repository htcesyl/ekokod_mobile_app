// lib/application/analytics/analytics_state.dart
// Analytics sayfasının durumlarını yönetir

part of 'analytics_cubit.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

class AnalyticsLoaded extends AnalyticsState {
  final List<ChartPointEntity>? consumptionData;
  final List<ChartPointEntity>? loadProfileData;
  final Map<String, String> buildingNameToId; // Bina ismi -> Bina ID mapping
  final PeriodType? selectedPeriod; // Seçili period (grafik görünümü için)

  const AnalyticsLoaded({
    this.consumptionData,
    this.loadProfileData,
    required this.buildingNameToId,
    this.selectedPeriod,
  });

  @override
  List<Object?> get props => [consumptionData, loadProfileData, buildingNameToId, selectedPeriod];
}

class AnalyticsError extends AnalyticsState {
  final String message;

  const AnalyticsError({required this.message});

  @override
  List<Object?> get props => [message];
}
