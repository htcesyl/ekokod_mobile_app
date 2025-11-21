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

  // Seçili ikon ve yazı için özel widget (yuvarlak beyaz arka plan + yeşil ikon ve yazı)
  Widget _buildIcon(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;
    
    if (isSelected) {
      return SizedBox(
        width: 80, // Sabit genişlik
        height: 60, // Sabit yükseklik
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF09a42b),
                size: 24,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF09a42b),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 80, // Seçili item ile aynı genişlik
        height: 60, // Seçili item ile aynı yükseklik
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF09a42b),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF09a42b),
          unselectedItemColor: Colors.white,
          selectedItemColor: const Color(0xFF09a42b),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,

          currentIndex: selectedIndex,
          onTap: (index) {
            final item = _items[index];
            context.goNamed(item.routeName);
          },

        items:
            _items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return BottomNavigationBarItem(
                icon: _buildIcon(item.icon, item.label, index),
                label: '', // Label'ı boş bırakıyoruz çünkü icon içinde gösteriyoruz
              );
            }).toList(),
        ),
      ),
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
