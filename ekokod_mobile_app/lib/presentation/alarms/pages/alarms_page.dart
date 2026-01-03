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
      return DateFormat('dd MMM yyyy, HH:mm').format(date);
    }
    return DateFormat('dd MMMM yyyy, HH:mm', 'tr_TR').format(date);
  }

  // ----------------------------
  // UI Helper'lar (tekilleştirme)
  // ----------------------------
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildBuildingFilter() {
    return Row(
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
    );
  }

  Widget _buildActiveAlarmsHeader() {
    return const Text(
      'Aktif Alarmlar',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.notifications_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Aktif alarm bulunmuyor',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'Hata: $message',
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ✅ İlk açılışta fetch burada tetikleniyor (AlarmInitial bloğundaki duplicate akış kalktı)
      create: (_) => sl<AlarmCubit>()..fetchAlarms(),
      child: Container(
        decoration: const BoxDecoration(gradient: secondBackgroundGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(weatherData: '21°C'),
          bottomNavigationBar: const MainBottomNavBar(selectedIndex: 3),
          body: BlocBuilder<AlarmCubit, AlarmState>(
            builder: (context, state) {
              if (state is AlarmInitial || state is AlarmLoading) {
                return _buildLoading();
              }

              if (state is AlarmError) {
                return _buildErrorState(context, state.message);
              }

              if (state is AlarmLoaded) {
                final alarms = state.alarms;

                // ✅ Scroll + Padding + Column tek yerde
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBuildingFilter(),
                      const SizedBox(height: 20),
                      _buildActiveAlarmsHeader(),
                      const SizedBox(height: 10),

                      if (alarms.isEmpty)
                        _buildEmptyState()
                      else
                        ...alarms.map((alarm) {
                          final latestLog = alarm.logs.isNotEmpty
                              ? alarm.logs.reduce(
                                  (a, b) =>
                                      a.timestamp.isAfter(b.timestamp) ? a : b,
                                )
                              : null;

                          return _buildAlarmItem(
                            alarm: alarm,
                            latestLog: latestLog,
                          );
                        }),

                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }

              return _buildLoading();
            },
          ),
        ),
      ),
    );
  }

  // Her bir alarm öğesini temsil eden ve tüm log geçmişini gösteren kart
  Widget _buildAlarmItem({required AlarmEntity alarm, AlarmLog? latestLog}) {
    final alarmName = alarm.name;
    final alarmType = alarm.type;
    final logDate = latestLog?.timestamp ?? alarm.updatedAt;

    final sortedLogs = List<AlarmLog>.from(alarm.logs)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

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
          value: true,
          onChanged: (bool value) {
            // TODO: Alarm durumunu güncelleme Cubit çağrısı
          },
          activeColor: AppColors.webColor,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sortedLogs.isEmpty)
                  const Text('Log kaydı bulunamadı.')
                else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Log Geçmişi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Toplam ${sortedLogs.length} kayıt',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ...sortedLogs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final log = entry.value;
                    final isFirst = index == 0;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isFirst
                            ? AppColors.webColor.withValues(alpha: 0.1)
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isFirst
                              ? AppColors.webColor.withValues(alpha: 0.3)
                              : Colors.grey[200]!,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDate(log.timestamp),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: isFirst
                                      ? AppColors.webColor
                                      : Colors.grey[700],
                                ),
                              ),
                              if (isFirst)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.webColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Yeni',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          if (log.message.isNotEmpty)
                            Text(
                              log.message,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          if (log.details.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              log.details,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
