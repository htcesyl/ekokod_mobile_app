// lib/application/bills/bills_state.dart
// Bills sayfası için state yönetimi
// Clean Architecture: Application layer - state management

part of 'bills_cubit.dart';

abstract class BillsState extends Equatable {
  const BillsState();

  @override
  List<Object?> get props => [];
}

class BillsInitial extends BillsState {
  const BillsInitial();
}

class BillsLoading extends BillsState {
  const BillsLoading();
}

class BillsLoaded extends BillsState {
  final List<BuildingEntity> buildings;
  final BuildingEntity? selectedBuilding;
  final BillHistoryItemEntity? latestBill;
  final List<ChartPointEntity>? billsChartData; // Son 12 ay için grafik verisi

  const BillsLoaded({
    required this.buildings,
    this.selectedBuilding,
    this.latestBill,
    this.billsChartData,
  });

  BillsLoaded copyWith({
    List<BuildingEntity>? buildings,
    BuildingEntity? selectedBuilding,
    BillHistoryItemEntity? latestBill,
    List<ChartPointEntity>? billsChartData,
  }) {
    return BillsLoaded(
      buildings: buildings ?? this.buildings,
      selectedBuilding: selectedBuilding ?? this.selectedBuilding,
      latestBill: latestBill ?? this.latestBill,
      billsChartData: billsChartData ?? this.billsChartData,
    );
  }

  @override
  List<Object?> get props => [buildings, selectedBuilding, latestBill, billsChartData];
}

class BillsError extends BillsState {
  final String message;

  const BillsError({required this.message});

  @override
  List<Object?> get props => [message];
}
