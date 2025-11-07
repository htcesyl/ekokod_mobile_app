import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart'; // yolu kendi projenize göre ayarlayın

enum BrandLogoMode { halo, plate, boost, plain }

class BrandLogo extends StatelessWidget {
  /// Logo yüksekliği (genişlik, görsele göre otomatik)
  final double size;

  /// Görsel modu: halo | plate | boost | plain
  final BrandLogoMode mode;

  /// İstersen farklı bir görsel yolu verebilirsin (varsayılan AppAssets.logo)
  final String? assetPath;

  /// Tek renk boyamak istersen (örn: Colors.white). null -> orijinal renkler
  final Color? tintColor;

  /// Semantik label (erişilebilirlik)
  final String? semanticLabel;

  const BrandLogo({
    super.key,
    this.size = 120,
    this.mode = BrandLogoMode.halo,
    this.assetPath,
    this.tintColor,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final img = Image.asset(
      assetPath ?? AppAssets.logo,
      height: size,
      fit: BoxFit.contain,
      color: tintColor,
      colorBlendMode: tintColor != null ? BlendMode.srcIn : null,
      semanticLabel: semanticLabel,
    );

    switch (mode) {
      case BrandLogoMode.halo:
        return _Halo(child: img, size: size);
      case BrandLogoMode.plate:
        return _Plate(child: img);
      case BrandLogoMode.boost:
        return _Boost(child: img);
      case BrandLogoMode.plain:
      default:
        return img;
    }
  }
}

class _Halo extends StatelessWidget {
  final Widget child;
  final double size;
  const _Halo({required this.child, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size * 1.6,
          height: size * 1.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.16), // hafif parlaklık
                Colors.white.withOpacity(0.00),
              ],
              radius: 0.65,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _Plate extends StatelessWidget {
  final Widget child;
  const _Plate({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Boost extends StatelessWidget {
  final Widget child;
  const _Boost({required this.child});

  // Basit parlaklık/kontrast matrisi: b: 0..0.3, c: 1..1.2
  List<double> _brightnessContrastMatrix({double b = 0.10, double c = 1.05}) {
    return <double>[
      c, 0, 0, 0, 255 * b, // R
      0, c, 0, 0, 255 * b, // G
      0, 0, c, 0, 255 * b, // B
      0, 0, 0, 1, 0, // A
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(_brightnessContrastMatrix()),
      child: child,
    );
  }
}
