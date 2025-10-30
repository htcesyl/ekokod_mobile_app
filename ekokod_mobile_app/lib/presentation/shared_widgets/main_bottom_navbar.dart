import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';

class MainBottomNavBar extends StatelessWidget {
  // Seçili olan sayfanın indeksini dışarıdan alır.
  final int selectedIndex;

  const MainBottomNavBar({required this.selectedIndex, super.key});

  static const List<_NavItem> _items = [
    _NavItem(
      icon: Icons.home_outlined,
      label: 'Anasayfa',
      routeName: RouteNames.home,
    ),
    _NavItem(
      icon: Icons.bar_chart,
      label: 'Veri Analizi',
      routeName: RouteNames.analytics,
    ),
    _NavItem(
      icon: Icons.list_alt,
      label: 'Faturalar',
      routeName: RouteNames.bills,
    ),
    _NavItem(
      icon: Icons.notifications_none,
      label: 'Alarm',
      routeName: RouteNames.alarms,
    ),
    _NavItem(icon: Icons.menu, label: 'Menü', routeName: RouteNames.menu),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Arka plan rengi beyaz
      backgroundColor: Colors.white,
      // Seçili olmayan ikonların rengi
      unselectedItemColor: const Color(0x4F000000),
      // Seçili ikonun rengi
      selectedItemColor: const Color(0xFF2E7D32),
      // Etiketlerin her zaman görünmesini sağlar
      showUnselectedLabels: true,

      currentIndex: selectedIndex,
      onTap: (index) {
        final item = _items[index];
        context.goNamed(item.routeName);
      },

      items:
          _items.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            );
          }).toList(),
    );
  }
}

// Navigasyon elemanı veri yapısı
class _NavItem {
  final IconData icon;
  final String label;
  final String routeName;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.routeName,
  });
}
