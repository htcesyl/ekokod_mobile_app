import '../../data/models/bill_history_item_model.dart';

/// BillHistory map parse işlemleri için helper sınıf
class BillHistoryParser {
  /// JSON'dan gelen Map<String, dynamic> formatını
  /// Map<String, BillHistoryItemModel> formatına çevirir
  static Map<String, BillHistoryItemModel> parseBillHistory(
    Map<String, dynamic>? billHistoryJson,
  ) {
    if (billHistoryJson == null || billHistoryJson.isEmpty) {
      return {};
    }

    return billHistoryJson.map(
      (key, value) => MapEntry(
        key,
        BillHistoryItemModel.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  /// BillHistory map'inden belirli bir ayı getirir
  static BillHistoryItemModel? getMonthBill(
    Map<String, BillHistoryItemModel>? billHistory,
    String monthKey, // "2025-12" formatında
  ) {
    if (billHistory == null || billHistory.isEmpty) {
      return null;
    }

    return billHistory[monthKey];
  }

  /// BillHistory map'inden tüm ay anahtarlarını getirir (sıralı)
  static List<String> getMonthKeys(
    Map<String, BillHistoryItemModel>? billHistory,
  ) {
    if (billHistory == null || billHistory.isEmpty) {
      return [];
    }

    final keys = billHistory.keys.toList();
    // YYYY-MM formatında olduğu için string sıralama yeterli
    keys.sort((a, b) => b.compareTo(a)); // En yeni önce (descending)
    return keys;
  }

  /// BillHistory map'inden en son faturayı getirir
  static BillHistoryItemModel? getLatestBill(
    Map<String, BillHistoryItemModel>? billHistory,
  ) {
    if (billHistory == null || billHistory.isEmpty) {
      return null;
    }

    final keys = getMonthKeys(billHistory);
    if (keys.isEmpty) return null;

    return billHistory[keys.first];
  }

  /// Belirli bir tarih aralığındaki faturaları getirir
  static List<BillHistoryItemModel> getBillsInRange(
    Map<String, BillHistoryItemModel>? billHistory,
    String startMonthKey, // "2025-01"
    String endMonthKey, // "2025-12"
  ) {
    if (billHistory == null || billHistory.isEmpty) {
      return [];
    }

    final keys = getMonthKeys(billHistory);
    final filteredKeys = keys.where((key) {
      return key.compareTo(startMonthKey) >= 0 && key.compareTo(endMonthKey) <= 0;
    }).toList();

    return filteredKeys
        .map((key) => billHistory[key]!)
        .toList();
  }
}
