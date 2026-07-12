import 'package:flutter/material.dart';

/// Design Tokens จาก design_handoff_edlgen_monitoring (EDL-Gen Design System)
abstract final class AppColors {
  // Brand (จากโลโก้ EDL-GEN O&M)
  static const primary = Color(0xFF1A5CB0);
  static const primaryLight = Color(0xFF2E7BD6);
  static const primaryDark = Color(0xFF0E3B78);
  static const gold = Color(0xFFF4B700);
  static const goldDark = Color(0xFFD99C00);
  static const signalRed = Color(0xFFD8232A);

  // Surface & Neutral (Light)
  static const background = Color(0xFFF0F4FA);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFD6E0EF);
  static const textDark = Color(0xFF152641);
  static const textMedium = Color(0xFF44557A);
  static const textSubtle = Color(0xFF7C8CA8);

  // Semantic
  static const success = Color(0xFF178A4C);
  static const successBg = Color(0xFFDDF5E7);
  static const warning = Color(0xFFD99C00);
  static const warningBg = Color(0xFFFFF4CC);
  static const critical = Color(0xFFD8232A);
  static const criticalBg = Color(0xFFFDE3E4);
  static const info = Color(0xFF0E4E8F);
  static const infoBg = Color(0xFFE1EEFB);

  // Dark Mode
  static const darkBg = Color(0xFF0B1626);
  static const darkCard = Color(0xFF132238);
  static const darkCard2 = Color(0xFF182B45);
  static const darkBorder = Color(0xFF24395B);
  static const darkText = Color(0xFFE8F0FB);
  static const darkSubtle = Color(0xFF8299BE);
  static const darkPrimary = Color(0xFF5A9BE8);

  /// Gradient หลักของ Header/Hero (170deg #2E7BD6 → #1A5CB0 → #0E3B78)
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary, primaryDark],
  );

  static const goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, goldDark],
  );
}
