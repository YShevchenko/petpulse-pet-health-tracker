import 'package:flutter/material.dart';

/// Warm, friendly color palette for PetPulse.
class AppColors {
  AppColors._();

  // Primary palette
  static const Color background = Color(0xFFF5F0EB); // warm cream
  static const Color surface = Color(0xFFFFFFFF); // white
  static const Color primary = Color(0xFF4A90D9); // trustworthy blue
  static const Color primaryLight = Color(0xFF7CB3E8);
  static const Color primaryDark = Color(0xFF2D6FB5);
  static const Color secondary = Color(0xFFFF8C42); // warm orange
  static const Color secondaryLight = Color(0xFFFFAD73);
  static const Color secondaryDark = Color(0xFFE06D1F);
  static const Color accent = Color(0xFF5CB85C); // healthy green
  static const Color accentLight = Color(0xFF8ED08E);
  static const Color accentDark = Color(0xFF3D9B3D);

  // Status colors
  static const Color error = Color(0xFFE74C3C); // red
  static const Color warning = Color(0xFFF39C12); // amber
  static const Color success = Color(0xFF5CB85C); // green
  static const Color info = Color(0xFF4A90D9); // blue

  // Text colors
  static const Color textPrimary = Color(0xFF2C3E50); // dark slate
  static const Color textSecondary = Color(0xFF7F8C8D); // grey
  static const Color textLight = Color(0xFFBDC3C7); // light grey
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Expiry badge colors
  static const Color expiryGreen = Color(0xFF5CB85C);
  static const Color expiryYellow = Color(0xFFF39C12);
  static const Color expiryRed = Color(0xFFE74C3C);

  // Divider / border
  static const Color divider = Color(0xFFE0D8CF);
  static const Color border = Color(0xFFD5CDC4);

  // Card shadow
  static const Color shadow = Color(0x1A000000);

  // Species icon colors
  static const Color dogColor = Color(0xFF8B6914);
  static const Color catColor = Color(0xFF9B59B6);
  static const Color birdColor = Color(0xFF3498DB);
  static const Color rabbitColor = Color(0xFFE67E22);
  static const Color otherColor = Color(0xFF95A5A6);
}
