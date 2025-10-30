import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';
import 'package:ekokod_mobile_app/presentation/shared_widgets/main_bottom_navbar.dart';
import 'package:ekokod_mobile_app/presentation/shared_widgets/data_summary_card.dart';
import 'package:ekokod_mobile_app/presentation/shared_widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: secondBackgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: const CustomAppBar(pageTitle: 'Anasayfa', weatherData: '21°C'),

        bottomNavigationBar: const MainBottomNavBar(selectedIndex: 0),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSummaryCards(context),
              const SizedBox(height: 24),

              _buildElectricityConsumptionChart(context),
              const SizedBox(height: 24),

              _buildLastMonthBillSummary(context),
              const SizedBox(height: 24),

              _buildDemandSummary(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ***************************************************************
  // YARDIMCI METOTLAR
  // ***************************************************************

  Widget _buildSummaryCards(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: DataSummaryCard(
            title: 'Reaktif Ceza Durumu',
            value: '₺0,00',
            isCurrency: true,
          ),
        ),
        SizedBox(width: 16),

        Expanded(
          child: DataSummaryCard(
            title: 'Bugünlük Tüketim',
            value: '32.40 kWh',
            isCurrency: false,
          ),
        ),
      ],
    );
  }

  // 3. Elektrik Tüketimi Grafiği Metodu
  Widget _buildElectricityConsumptionChart(BuildContext context) {
    // Grafiği ve özetini saran ana kapsayıcı (Card görünümü için)
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Elektrik Tüketimi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Ana Tüketim Değeri (API'den gelecek)
              const Text(
                'Eylül 2025\n1.600,00 kWh',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              // Kapasitif ve Endüktif Etiketler
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildConsumptionTag(
                    'Kapasitif',
                    '%0,58',
                    const Color(0xFF6DCF60),
                  ),
                  _buildConsumptionTag(
                    'Endüktif',
                    '%2,45',
                    const Color(0xFF6DCF60),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // GRAFİK ALANI () fl_chart)
          Container(
            height: 200,
            color: Colors.grey[100],
            child: const Center(
              child: Text('Yıllık Tüketim Grafiği (API Verisi)'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsumptionTag(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2), // Hafif arka plan rengi
        borderRadius: BorderRadius.circular(41),
      ),
      child: Text(
        '$label $value',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // 4. Son Ay Fatura Özeti Metodu
  Widget _buildLastMonthBillSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Son Ay Fatura',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Tutar ve Birim Fiyat Yan Yana
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Fatura Tutarı (₺4.608,25)
              const Column(
                children: [
                  Text('Eylül 2025', style: TextStyle(color: Colors.black54)),
                  Text(
                    '₺4.608,25',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B441A),
                    ),
                  ),
                ],
              ),
              // Birim Fiyat (₺4,90)
              const Column(
                children: [
                  Text('Birim Fiyat', style: TextStyle(color: Colors.black54)),
                  Text(
                    '₺4,90',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B441A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Fatura Detayı Butonu
          SizedBox(
            width: double.infinity, // Butonu tam genişlik yapar
            child: ElevatedButton(
              onPressed: () {
                // Tıklanma olayı: GoRouter ile Fatura Detay sayfasına yönlendirilir.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF396334),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(41),
                ),
              ),
              child: const Text(
                'Fatura Detayı',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 5. DEMAND Güç Özeti Metodu
  Widget _buildDemandSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık ve Tarih
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DEMAND',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('1 Eylül 15.15', style: TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 16),

          LinearProgressIndicator(
            value:
                0.8, // API'den gelen Demand oranına göre doluluk (0.0 ile 1.0 arası)
            minHeight: 10,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF396334),
            ), // Yeşil doluluk rengi
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 16),

          // Açıklama Metinleri (Demand, Sözleşme Gücü, Kurulu Güç)
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DemandMetricWidget(
                label: 'Demand',
                value: '84 kW',
                color: Colors.red,
              ),
              DemandMetricWidget(
                label: 'Sözleşme Gücü',
                value: '84 kW',
                color: Color(0xFF6DCF60),
              ), // Yeşil-Sarı Tonu
              DemandMetricWidget(
                label: 'Kurulu Güç',
                value: '84 kW',
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
