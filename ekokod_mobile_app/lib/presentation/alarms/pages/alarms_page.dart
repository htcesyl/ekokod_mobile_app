import 'package:flutter/material.dart';
import '../../../core/constants/app_themes.dart';
import '../../shared_widgets/app_bar.dart';
import '../../shared_widgets/main_bottom_navbar.dart';
import '../../shared_widgets/custom_dropdown.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // Mock Filtre Değişkenleri (Cubit entegrasyonundan sonra Cubit State'inden alınacak)
  String _selectedBuilding = 'Bina 1';
  final List<String> _buildings = ['Bina 1', 'Bina 2', 'Tüm Binalar'];

  // Mock Alarmlar (Cubit'ten gelecek)
  final List<String> _mockAlarms = [
    'Tüketim Limiti Aşıldı (Bina 1)',
    'Reaktif Ceza Riski (Bina 2)',
    'Sayaç Bağlantı Hatası',
  ];

  void _handleBuildingChange(String? building) {
    if (building != null) {
      setState(() {
        _selectedBuilding = building;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sayfa Arkaplan Gradyanı
    return Container(
      decoration: const BoxDecoration(
        // Diğer sayfalarda kullanılan gradyanı kullanıyoruz
        gradient: secondBackgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Gradyanın görünmesi için şeffaf
        // Custom AppBar
        appBar: const CustomAppBar(
          weatherData: '21°C', // Mock Hava Durumu
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: const MainBottomNavBar(
          selectedIndex: 3, // 'Alarm' sayfasının indeksi (0, 1, 2, 3)
        ),


        // Sayfa İçeriği
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------
              // 1. Bina Seçimi Filtresi
              // ------------------------------------
              Row(
                children: [
                  const Text('Bina Seçiniz', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 10),
                  CustomDropdown(
                    label: '',
                    selectedItem: _selectedBuilding,
                    items: _buildings,
                    onChanged: _handleBuildingChange,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // ------------------------------------
              // 2. Aktif Alarmlar Başlığı
              // ------------------------------------
              const Text(
                'Aktif Alarmlar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Alarmlar Listesi
              ..._mockAlarms.map((alarm) => _buildAlarmItem(alarm)).toList(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Her bir alarm öğesini temsil eden basit kart
  Widget _buildAlarmItem(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.notifications_active, color: AppColors.webColor),
        title: Text(title),
        subtitle: const Text('23 Ekim 2025, 14:30'),
        trailing: Switch(
          value: true, // Mock değeri
          onChanged: (bool value) {
            // TODO: Alarm durumunu güncelleme Cubit çağrısı
          },
          activeColor: AppColors.webColor,
        ),
      ),
    );
  }
}
