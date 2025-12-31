// lib/application/home/home_cubit.dart
// Home sayfası için state yönetimi
// Clean Architecture: Application layer - state management

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/daily_production_consumption_entity.dart';
import 'get_daily_production_consumption_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetDailyProductionConsumptionUseCase getDailyProductionConsumptionUseCase;

  HomeCubit({
    required this.getDailyProductionConsumptionUseCase,
  }) : super(const HomeInitial());

  /// Belirli bir tarih için günlük üretim ve tüketim verilerini yükler
  /// 
  /// [date] ISO format: "2025-12-14" veya "2025-12-14T00:00:00.000Z"
  Future<void> loadDailyProductionConsumption({required String date}) async {
    emit(const HomeLoading());

    try {
      final data = await getDailyProductionConsumptionUseCase(date: date);
      
      if (data != null) {
        emit(HomeLoaded(data: data));
      } else {
        emit(const HomeError(message: 'Veri bulunamadı'));
      }
    } catch (e, st) {
      print('❌ Günlük üretim-tüketim verisi çekilirken hata: $e');
      print(st);
      emit(HomeError(message: e.toString()));
    }
  }

  /// En son eklenen günlük üretim ve tüketim verisini yükler
  Future<void> loadLatestProductionConsumption() async {
    emit(const HomeLoading());

    try {
      final data = await getDailyProductionConsumptionUseCase.getLatest();
      
      if (data != null) {
        emit(HomeLoaded(data: data));
      } else {
        emit(const HomeError(message: 'Veri bulunamadı'));
      }
    } catch (e, st) {
      print('❌ En son üretim-tüketim verisi çekilirken hata: $e');
      print(st);
      emit(HomeError(message: e.toString()));
    }
  }

  /// Verileri yeniler (en son veriyi çeker)
  Future<void> refresh() async {
    await loadLatestProductionConsumption();
  }
}
