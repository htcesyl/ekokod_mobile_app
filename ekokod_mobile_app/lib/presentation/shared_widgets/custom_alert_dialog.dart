import 'package:flutter/material.dart';
import '../../core/constants/app_themes.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String? cancelText; // Opsiyonel (Confirmation için kullanılır)
  final VoidCallback onConfirm;
  final VoidCallback? onCancel; // Opsiyonel (Confirmation için kullanılır)
  final bool isDestructive; // Kırmızı renkli bir onay butonu için

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText = 'Tamam',
    this.cancelText,
    this.onCancel,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    // Onay butonu rengi: Kırmızı (isDestructive) veya Koyu Yeşil (varsayılan)
    final Color confirmButtonColor =
        isDestructive ? Colors.red : AppColors.mediumGreen;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(content),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      actions: [
        // İptal Butonu (Eğer cancelText ve onCancel tanımlıysa)
        if (cancelText != null)
          TextButton(
            onPressed: () {
              // Eğer onCancel tanımlıysa onu çağır, aksi takdirde pop yap.
              onCancel?.call();
              Navigator.of(context).pop();
            },
            child: Text(
              cancelText!,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ),

        // Onay Butonu (Mutlaka olmalı)
        ElevatedButton(
          onPressed: () {
            // Onay işlevini çağır
            onConfirm();
            // Alert'ü kapat
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
          child: Text(
            confirmText,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

// Widget'ı göstermek için yardımcı fonksiyon
Future<T?> showCustomAlert<T>(
  BuildContext context, {
  required String title,
  required String content,
  required VoidCallback onConfirm,
  String confirmText = 'Tamam',
  String? cancelText,
  VoidCallback? onCancel,
  bool isDestructive = false,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
        confirmText: confirmText,
        cancelText: cancelText,
        onCancel: onCancel,
        isDestructive: isDestructive,
      );
    },
  );
}
