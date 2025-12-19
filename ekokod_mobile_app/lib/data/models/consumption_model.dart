import 'package:json_annotation/json_annotation.dart';
import 'package:ekokod_mobile_app/domain/entities/chart_entity.dart';

part 'consumption_model.g.dart';

@JsonSerializable()
class ConsumptionPointModel {
  final String periodLabel;
  final double activeIndex;
  final double indIndex;
  final double capIndex;
  final double t1Index;
  final double t2Index;
  final double t3Index;
  final double activeGenerationIndex;
  final double indGenerationIndex;
  final double capGenerationIndex;
  final double u1Index;
  final double u2Index;
  final double u3Index;
  final double activeConsumption;
  final double indConsumption;
  final double capConsumption;
  final double indRate;
  final double capRate;
  final double t1Consumption;
  final double t2Consumption;
  final double t3Consumption;
  final double activeGeneration;
  final double indGeneration;
  final double capGeneration;
  final double u1Generation;
  final double u2Generation;
  final double u3Generation;

  ConsumptionPointModel({
    required this.periodLabel,
    required this.activeIndex,
    required this.indIndex,
    required this.capIndex,
    required this.t1Index,
    required this.t2Index,
    required this.t3Index,
    required this.activeGenerationIndex,
    required this.indGenerationIndex,
    required this.capGenerationIndex,
    required this.u1Index,
    required this.u2Index,
    required this.u3Index,
    required this.activeConsumption,
    required this.indConsumption,
    required this.capConsumption,
    required this.indRate,
    required this.capRate,
    required this.t1Consumption,
    required this.t2Consumption,
    required this.t3Consumption,
    required this.activeGeneration,
    required this.indGeneration,
    required this.capGeneration,
    required this.u1Generation,
    required this.u2Generation,
    required this.u3Generation,
  });

  factory ConsumptionPointModel.fromJson(Map<String, dynamic> json) =>
      _$ConsumptionPointModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumptionPointModelToJson(this);

  /// periodLabel'ı DateTime'a çevirir
  /// daily: "01/10/2025" -> DateTime
  /// monthly: "10/2025" -> DateTime (ayın ilk günü)
  DateTime? parsePeriodLabel() {
    try {
      // Daily format: "01/10/2025" (DD/MM/YYYY)
      if (periodLabel.contains('/') && periodLabel.split('/').length == 3) {
        final parts = periodLabel.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }
      
      // Monthly format: "10/2025" (MM/YYYY)
      if (periodLabel.contains('/') && periodLabel.split('/').length == 2) {
        final parts = periodLabel.split('/');
        if (parts.length == 2) {
          final month = int.parse(parts[0]);
          final year = int.parse(parts[1]);
          return DateTime(year, month, 1); // Ayın ilk günü
        }
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Entity conversion method
  ChartPointEntity toEntity() {
    return ChartPointEntity(
      timestamp: parsePeriodLabel() ?? DateTime.now(),
      value: activeConsumption,
    );
  }
}

@JsonSerializable()
class PaginationModel {
  final int total;
  final int page;
  final int totalPages;

  PaginationModel({
    required this.total,
    required this.page,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

@JsonSerializable()
class ConsumptionResponseModel {
  // Tek analizör için
  final List<ConsumptionPointModel>? consumption;
  
  // Çoklu analizör için (format farklı)
  final Map<String, List<ConsumptionPointModel>>? consumptions;
  
  final PaginationModel? pagination;

  ConsumptionResponseModel({
    this.consumption,
    this.consumptions,
    this.pagination,
  });

  factory ConsumptionResponseModel.fromJson(Map<String, dynamic> json) {
    // Response formatını kontrol et
    if (json.containsKey('consumption') && json['consumption'] != null) {
      // Tek analizör formatı
      return ConsumptionResponseModel(
        consumption: (json['consumption'] as List)
            .map((e) => ConsumptionPointModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: json['pagination'] != null
            ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
            : null,
      );
    } else if (json.containsKey('consumptions') && json['consumptions'] != null) {
      // Çoklu analizör formatı
      final consumptionsMap = json['consumptions'] as Map<String, dynamic>;
      final parsedConsumptions = <String, List<ConsumptionPointModel>>{};
      
      consumptionsMap.forEach((analyzerId, data) {
        parsedConsumptions[analyzerId] = (data as List)
            .map((e) => ConsumptionPointModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });
      
      return ConsumptionResponseModel(
        consumptions: parsedConsumptions,
        pagination: json['pagination'] != null
            ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
            : null,
      );
    }
    
    return ConsumptionResponseModel();
  }

  Map<String, dynamic> toJson() => _$ConsumptionResponseModelToJson(this);
}

// Extension for Entity conversion
extension ConsumptionPointModelExtension on ConsumptionPointModel {
  /// periodLabel'ı DateTime'a çevirir
  /// daily: "01/10/2025" -> DateTime
  /// monthly: "10/2025" -> DateTime (ayın ilk günü)
  DateTime? parsePeriodLabel() {
    try {
      // Daily format: "01/10/2025" (DD/MM/YYYY)
      if (periodLabel.contains('/') && periodLabel.split('/').length == 3) {
        final parts = periodLabel.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }
      
      // Monthly format: "10/2025" (MM/YYYY)
      if (periodLabel.contains('/') && periodLabel.split('/').length == 2) {
        final parts = periodLabel.split('/');
        if (parts.length == 2) {
          final month = int.parse(parts[0]);
          final year = int.parse(parts[1]);
          return DateTime(year, month, 1); // Ayın ilk günü
        }
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  ChartPointEntity toEntity() {
    return ChartPointEntity(
      timestamp: parsePeriodLabel() ?? DateTime.now(),
      value: activeConsumption,
    );
  }
}
