import 'package:json_annotation/json_annotation.dart';
import 'bill_history_item_model.dart';
import 'package:ekokod_mobile_app/domain/entities/analyzer_entity.dart';
import 'package:ekokod_mobile_app/domain/entities/bill_history_entity.dart';

part 'analyzer_model.g.dart';

@JsonSerializable()
class AnalyzerModel {
  @JsonKey(name: '_id')
  final String id;
  final String building;
  final String subIntegration;
  final String installationNumber;
  final String customerName;
  final String address;
  final String? il;
  final String? ilce;
  final String? koyMahallesi;
  final String? caddesiSokagi;
  final String? tarifeTipi;
  final String? tarifeTuru;
  final String? tesisatTurTanim;
  final String kuruluGucu;
  final String? koordinatX;
  final String? koordinatY;
  final String meterNumber;
  final String meterModel;
  final String meterMultiplier;
  final String? muhatapNo;
  final String? sayimNokTanim;
  final String? lastLoadProfileDate;
  final String? lastEndexDate;
  final int definitionType;
  final DateTime? lastDataDate;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  
  // billHistory Map<String, BillHistoryItemModel> olarak parse edilecek
  @JsonKey(name: 'billHistory')
  final Map<String, dynamic>? billHistoryJson;

  AnalyzerModel({
    required this.id,
    required this.building,
    required this.subIntegration,
    required this.installationNumber,
    required this.customerName,
    required this.address,
    this.il,
    this.ilce,
    this.koyMahallesi,
    this.caddesiSokagi,
    this.tarifeTipi,
    this.tarifeTuru,
    this.tesisatTurTanim,
    required this.kuruluGucu,
    this.koordinatX,
    this.koordinatY,
    required this.meterNumber,
    required this.meterModel,
    required this.meterMultiplier,
    this.muhatapNo,
    this.sayimNokTanim,
    this.lastLoadProfileDate,
    this.lastEndexDate,
    required this.definitionType,
    this.lastDataDate,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.billHistoryJson,
  });

  factory AnalyzerModel.fromJson(Map<String, dynamic> json) =>
      _$AnalyzerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzerModelToJson(this);

  // Helper method: billHistory map'ini parse et
  Map<String, BillHistoryItemModel>? get billHistory {
    if (billHistoryJson == null) return null;
    
    return billHistoryJson!.map(
      (key, value) => MapEntry(
        key,
        BillHistoryItemModel.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  // Kurulu gücü double olarak al (reaktif ceza hesaplaması için)
  double get kuruluGucDouble {
    try {
      return double.parse(kuruluGucu);
    } catch (e) {
      return 0.0;
    }
  }

  // Entity conversion method
  AnalyzerEntity toEntity() {
    // billHistory map'ini entity'ye çevir
    Map<String, BillHistoryItemEntity>? billHistoryEntity;
    if (billHistory != null) {
      billHistoryEntity = billHistory!.map(
        (key, value) => MapEntry(key, value.toEntity()),
      );
    }

    return AnalyzerEntity(
      id: id,
      buildingId: building,
      subIntegration: subIntegration,
      installationNumber: installationNumber,
      customerName: customerName,
      address: address,
      kuruluGucu: kuruluGucu,
      meterNumber: meterNumber,
      meterModel: meterModel,
      meterMultiplier: meterMultiplier,
      definitionType: definitionType,
      lastDataDate: lastDataDate,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      billHistory: billHistoryEntity,
    );
  }
}

@JsonSerializable()
class AnalyzerResponseModel {
  final bool success;
  final List<AnalyzerModel> analyzers;

  AnalyzerResponseModel({
    required this.success,
    required this.analyzers,
  });

  factory AnalyzerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AnalyzerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzerResponseModelToJson(this);
}

// Extension for Entity conversion
extension AnalyzerModelExtension on AnalyzerModel {
  AnalyzerEntity toEntity() {
    // billHistory map'ini entity'ye çevir
    Map<String, BillHistoryItemEntity>? billHistoryEntity;
    if (billHistory != null) {
      billHistoryEntity = billHistory!.map(
        (key, value) => MapEntry(key, value.toEntity()),
      );
    }

    return AnalyzerEntity(
      id: id,
      buildingId: building,
      subIntegration: subIntegration,
      installationNumber: installationNumber,
      customerName: customerName,
      address: address,
      kuruluGucu: kuruluGucu,
      meterNumber: meterNumber,
      meterModel: meterModel,
      meterMultiplier: meterMultiplier,
      definitionType: definitionType,
      lastDataDate: lastDataDate,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      billHistory: billHistoryEntity,
    );
  }
}
