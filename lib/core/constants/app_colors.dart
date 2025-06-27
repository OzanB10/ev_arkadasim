import 'package:flutter/material.dart';

/// EvArkadaşım uygulamasının renk paleti
/// 
/// Bu sınıf uygulamanın tüm renk değerlerini merkezi olarak yönetir.
/// Ev arkadaşlığı ve finansal güven teması için tasarlanmış modern renk paleti.
class AppColors {
  AppColors._();

  // Ana Markalar
  static const Color primary = Color(0xFF2DD4BF); // Teal - güven ve denge
  static const Color primaryDark = Color(0xFF0F766E); // Koyu teal
  static const Color primaryLight = Color(0xFF5EEAD4); // Açık teal
  
  static const Color secondary = Color(0xFF6366F1); // İndigo - teknoloji
  static const Color secondaryDark = Color(0xFF4338CA);
  static const Color secondaryLight = Color(0xFF8B5CF6);

  // Anlamsal Renkler
  static const Color success = Color(0xFF10B981); // Yeşil - başarı/ödeme
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF047857);
  
  static const Color warning = Color(0xFFF59E0B); // Amber - uyarı
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  
  static const Color error = Color(0xFFEF4444); // Kırmızı - hata/borç
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color info = Color(0xFF3B82F6); // Mavi - bilgi
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF1D4ED8);

  // Nötr Renkler (Light Mode)
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF8FAFC);
  
  static const Color textPrimaryLight = Color(0xFF1F2937);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);
  
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color dividerLight = Color(0xFFF3F4F6);

  // Nötr Renkler (Dark Mode)
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF334155);
  
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textTertiaryDark = Color(0xFF94A3B8);
  
  static const Color borderDark = Color(0xFF475569);
  static const Color dividerDark = Color(0xFF374151);

  // Özel Renkler (Finansal Durum)
  static const Color positive = success; // Alacak/pozitif bakiye
  static const Color negative = error; // Borç/negatif bakiye
  static const Color neutral = Color(0xFF64748B); // Sıfır bakiye
  
  // Kategori Renkleri (Gider kategorileri için)
  static const Color categoryFood = Color(0xFFFF6B6B); // Yemek
  static const Color categoryUtilities = Color(0xFF4ECDC4); // Faturalar
  static const Color categoryRent = Color(0xFF45B7D1); // Kira
  static const Color categoryShopping = Color(0xFF96CEB4); // Alışveriş
  static const Color categoryTransport = Color(0xFFFECE2F); // Ulaşım
  static const Color categoryEntertainment = Color(0xFFFFADD6); // Eğlence
  static const Color categoryOther = Color(0xFFDDA0DD); // Diğer

  // Gradient'lar
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [warning, warningLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow'lar
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.06),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // Helper methods
  static Color getBalanceColor(double balance) {
    if (balance > 0) return positive;
    if (balance < 0) return negative;
    return neutral;
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'yemek':
      case 'food':
        return categoryFood;
      case 'faturalar':
      case 'utilities':
        return categoryUtilities;
      case 'kira':
      case 'rent':
        return categoryRent;
      case 'alışveriş':
      case 'shopping':
        return categoryShopping;
      case 'ulaşım':
      case 'transport':
        return categoryTransport;
      case 'eğlence':
      case 'entertainment':
        return categoryEntertainment;
      default:
        return categoryOther;
    }
  }

  // Opacity helpers
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // Material 3 uyumlu renk paleti
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.light,
    primary: primary,
    secondary: secondary,
    error: error,
    surface: surfaceLight,
    background: backgroundLight,
  );

  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.dark,
    primary: primaryLight,
    secondary: secondaryLight,
    error: errorLight,
    surface: surfaceDark,
    background: backgroundDark,
  );
} 