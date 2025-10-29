import 'package:flutter/material.dart';
import '../../core/constants/app_themes.dart';
// Bina Entity'si, Dropdown'a veri sağlamak için Domain katmanından import edilecek
// import '../domain/entities/building_entity.dart'; // Eğer BuildingEntity hazırsa

// Dropdown'da kullanılacak veri tipi. Şimdilik String kullanıyoruz, Entity'ye geçilebilir.
typedef DropdownItem = String;

class CustomDropdown extends StatelessWidget {
  final String label; // "Bina Seçiniz" gibi etiket
  final DropdownItem selectedItem;
  final List<DropdownItem> items;
  final ValueChanged<DropdownItem?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Etiket ("Bina Seçiniz")
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              label,
              style: TextStyle(color: AppColors.black, fontSize: 14),
            ),
          ),
          // Dropdown Icon'ı
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.black,
            size: 20,
          ),
          const SizedBox(width: 4),

          // Değer (Bina 1, Bina 2 vb.)
          DropdownButton<DropdownItem>(
            value: selectedItem,
            icon: const SizedBox.shrink(), // Varsayılan ikonu kaldır
            underline: const SizedBox.shrink(), // Alt çizgiyi kaldır
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            items:
                items.map((DropdownItem item) {
                  return DropdownMenuItem<DropdownItem>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
