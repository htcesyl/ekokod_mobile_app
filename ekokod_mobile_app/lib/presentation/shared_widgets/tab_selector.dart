import 'package:flutter/material.dart';
import '../../domain/shared/enums.dart';
import '../../core/constants/app_themes.dart';

class TabSelector extends StatelessWidget {
  final AnalyticsTab selectedTab;

  final ValueChanged<AnalyticsTab> onTabSelected;

  const TabSelector({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  // Butonları oluşturmak için yardımcı metot
  Widget _buildTabButton({
    required BuildContext context,
    required String title,
    required AnalyticsTab tab,
  }) {
    final bool isActive = selectedTab == tab;

    final Color backgroundColor =
        isActive
            ? AppColors.activeTabBackground
            : AppColors.inactiveTabBackground; // Aktif olmayan D9D9D9 rengi

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(tab),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),

            border: Border.all(
              color:
                  isActive ? AppColors.activeTabBackground : Colors.transparent,
              width: 0.5,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // Tüketim, Üretim, Karbon Ayak İzi başlıklarını listeliyoruz
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton(
            context: context,
            title: 'Tüketim',
            tab: AnalyticsTab.consumption,
          ),
          const SizedBox(width: 8),
          _buildTabButton(
            context: context,
            title: 'Üretim',
            tab: AnalyticsTab.production,
          ),
          const SizedBox(width: 8),
          _buildTabButton(
            context: context,
            title: 'Karbon Ayak İzi',
            tab: AnalyticsTab.carbonFootprint,
          ),
        ],
      ),
    );
  }
}
