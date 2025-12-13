import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../core/constants/app_themes.dart';
import '../../../application/alarms/alarm_cubit.dart';
import '../../../domain/entities/alarm_entity.dart';
import '../../../injections/injection_container.dart';
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
  String _selectedBuilding = 'Tüm Binalar';
  final List<String> _buildings = ['Bina 1', 'Bina 2', 'Tüm Binalar'];
  bool _localeInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('tr_TR', null);
    if (mounted) {
      setState(() {
        _localeInitialized = true;
      });
    }
  }

  void _handleBuildingChange(String? building) {
    if (building != null) {
      setState(() {
        _selectedBuilding = building;
      });
    }
  }

  String _formatDate(DateTime date) {
    if (!_localeInitialized) {
      // Locale henüz initialize olmadıysa basit format kullan
      return DateFormat('dd MMM yyyy, HH:mm').format(date);
    }
    return DateFormat('dd MMMM yyyy, HH:mm', 'tr_TR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // Sayfa Arkaplan Gradyanı
    return BlocProvider(
      create: (_) => sl<AlarmCubit>(),
      child: Container(
        decoration: const BoxDecoration(
          // Diğer sayfalarda kullanılan gradyanı kullanıyoruz
          gradient: secondBackgroundGradient,
        ),
        child: Scaffold(
          backgroundColor:
              Colors.transparent, // Gradyanın görünmesi için şeffaf
          // Custom AppBar
          appBar: const CustomAppBar(
            weatherData: '21°C', // Mock Hava Durumu
          ),

          // Bottom Navigation Bar
          bottomNavigationBar: const MainBottomNavBar(
            selectedIndex: 3, // 'Alarm' sayfasının indeksi (0, 1, 2, 3)
          ),

          // Sayfa İçeriği
          body: BlocBuilder<AlarmCubit, AlarmState>(
            builder: (context, state) {
              // İlk yüklemede alarmları çek
              if (state is AlarmInitial) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<AlarmCubit>().fetchAlarms();
                });
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AlarmLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AlarmError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Hata: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AlarmCubit>().fetchAlarms();
                        },
                        child: const Text('Tekrar Dene'),
                      ),
                    ],
                  ),
                );
              }

              if (state is AlarmLoaded) {
                final alarms = state.alarms;

                // Eğer alarm yoksa
                if (alarms.isEmpty) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bina Seçimi Filtresi
                        Row(
                          children: [
                            const Text(
                              'Bina Seçiniz',
                              style: TextStyle(fontSize: 14),
                            ),
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
                        const Text(
                          'Aktif Alarmlar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.notifications_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aktif alarm bulunmuyor',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // En son log'u al (en güncel alarm bilgisi için)
                // Her alarm için en son log'u göster
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ------------------------------------
                      // 1. Bina Seçimi Filtresi
                      // ------------------------------------
                      Row(
                        children: [
                          const Text(
                            'Bina Seçiniz',
                            style: TextStyle(fontSize: 14),
                          ),
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
                      ...alarms.map((alarm) {
                        // En son log'u al
                        final latestLog =
                            alarm.logs.isNotEmpty
                                ? alarm.logs.reduce(
                                  (a, b) =>
                                      a.timestamp.isAfter(b.timestamp) ? a : b,
                                )
                                : null;

                        return _buildAlarmItem(
                          alarm: alarm,
                          latestLog: latestLog,
                        );
                      }).toList(),

                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }

              // Initial state
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  // Her bir alarm öğesini temsil eden basit kart
  Widget _buildAlarmItem({required AlarmEntity alarm, AlarmLog? latestLog}) {
    final alarmName = alarm.name;
    final alarmType = alarm.type;
    final logMessage = latestLog?.message ?? 'Alarm aktif';
    final logDetails = latestLog?.details ?? '';
    final logDate = latestLog?.timestamp ?? alarm.updatedAt;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ExpansionTile(
        leading: Icon(Icons.notifications_active, color: AppColors.webColor),
        title: Text(
          alarmName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (alarmType.isNotEmpty) ...[
              Text(
                alarmType,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              _formatDate(logDate),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: Switch(
          value: true, // Alarm aktif (şimdilik her zaman true)
          onChanged: (bool value) {
            // TODO: Alarm durumunu güncelleme Cubit çağrısı
          },
          activeColor: AppColors.webColor,
        ),
        children: [
          if (logMessage.isNotEmpty || logDetails.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (logMessage.isNotEmpty) ...[
                    Text(
                      'Mesaj:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(logMessage, style: const TextStyle(fontSize: 14)),
                  ],
                  if (logDetails.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Detay:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(logDetails, style: const TextStyle(fontSize: 14)),
                  ],
                  if (alarm.logs.length > 1) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Toplam ${alarm.logs.length} log kaydı',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
