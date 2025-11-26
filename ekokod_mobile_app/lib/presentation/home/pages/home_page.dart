import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_themes.dart';
import '../../../application/notification/notification_cubit.dart';
import 'package:ekokod_mobile_app/presentation/shared_widgets/main_bottom_navbar.dart';
import 'package:ekokod_mobile_app/presentation/shared_widgets/data_summary_card.dart';
import 'package:ekokod_mobile_app/presentation/shared_widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // TODO: Buraya gerçek login olmuş kullanıcının id'sini koyacaksın.
    const testUserId = 'test-user-123';

    // Push notification sistemini başlat:
    // - Bildirim izni iste
    // - FCM token al
    // - Token'ı backend'e kaydetmeye çalış
    // - Listener'ları kur
    context.read<NotificationCubit>().init(
          userId: testUserId,
          platform: 'android',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: secondBackgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: const CustomAppBar(weatherData: '21°C'),

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

  Widget _buildSummaryCards(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: DataSummaryCard(
            title: 'Günlük Tüketim',
            value: '32.40 kWh/Gün',
            isCurrency: false,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: DataSummaryCard(
            title: 'Günlük Üretim',
            value: '32.40 kWh/Gün',
            isCurrency: false,
          ),
        ),
      ],
    );
  }

  // 3. Elektrik Tüketimi Grafiği Metodu
  Widget _buildElectricityConsumptionChart(BuildContext context) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: Text(
                  'Son fatura dönemine\nait elektrik tüketimi',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(width: 50),
              Flexible(
                child: Text(
                  'Reaktif Ceza Durumu',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14),
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ekim 2025\n1.600,00 kWh/ay',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildConsumptionTag(
                    'Kapasitif',
                    '%0,58',
                    const Color(0xFF09a42b),
                  ),
                  _buildConsumptionTag(
                    'Endüktif ',
                    '%2,45',
                    const Color(0xFF09a42b),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
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

  static Widget _buildConsumptionTag(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Column(
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
              Column(
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Fatura detayı sayfasına yönlendirme
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.webColor,
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
            value: 0.8,
            minHeight: 10,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.webColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 16),
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
              ),
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
