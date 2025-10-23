
import 'package:flutter/material.dart';

class DataSummaryCard extends StatelessWidget {
  final String title;
  final String value;// API'den gelecek değer (Örn: "₺0,00" veya "32.40 kWh")
  final bool isCurrency; // Değerin TL (Ceza) mi yoksa kWh (Tüketim) mı olduğunu anlamak için

  const DataSummaryCard({
    required this.title,
    required this.value,
    required this.isCurrency,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],// Kartlara hafif gölge vererek öne çıkarıyoruz.
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık (Reaktif Ceza Durumu / Bugünlük Tüketim)
          Text(title, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 8),
          // Değer (₺0,00 / 32.40 kWh)
          Text(
            value,
            // API'den gelen veriye göre rengi belirliyoruz. Ceza (₺0,00) genelde kırmızıdır.
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isCurrency ? Colors.red : const Color(0xFF1B441A), 
            ),
          ),
        ],
      ),
    );
  }
}
class DemandMetricWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color color; // Kırmızı, Sarı, Gri nokta rengi

  const DemandMetricWidget({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // Metriklerin dikey olarak ortalanmasını sağlar
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Renkli Nokta
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        // Metrik Değeri (Örn: 84 kW)
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(width: 4),
        // Metrik Adı (Örn: Demand)
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }
}