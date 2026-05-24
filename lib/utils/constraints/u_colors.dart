import 'package:flutter/material.dart';

class UColors {
  UColors._();

  // --- Background & Card Colors from HTML CSS ---
  static const Color backgroundDark = Color(0xFF0F1117); // --bg: #0F1117
  static const Color surfaceDark = Color(0xFF1A1D27);    // --surface: #1A1D27
  static const Color surface2Dark = Color(0xFF22263A);   // --surface2: #22263A
  static const Color surface3Dark = Color(0xFF2A2F45);   // --surface3: #2A2F45

  // Light Mode Fallback Colors (Cream)
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color backgroundLight = Color(0xFFf3f6f4);

  // --- Accent & Action Colors from HTML CSS ---
  static const Color accentGold = Color(0xFFF4A93B);    // --accent: #F4A93B
  static const Color accentBlue = Color(0xFF3B82F6);    // --accent2: #3B82F6
  static const Color profitGreen = Color(0xFF22C55E);   // --green: #22C55E
  static const Color lossRed = Color(0xFFEF4444);       // --red: #EF4444
  static const Color purple = Color(0xFFA855F7);        // --purple: #A855F7

  // --- Text Colors from HTML CSS ---
  static const Color textPrimaryDark = Color(0xFFF1F5F9);  // --text: #F1F5F9
  static const Color textSecondaryDark = Color(0xFF94A3B8); // --text2: #94A3B8
  static const Color textMutedDark = Color(0xFF64748B);     // --text3: #64748B

  static const Color textPrimaryLight = Color(0xFF0F1117);
  static const Color textSecondaryLight = Color(0xFF475569);

  // --- Border Colors ---
  static const Color borderDark = Color(0x14FFFFFF);  // --border: rgba(255,255,255,0.08)
  static const Color border2Dark = Color(0x24FFFFFF); // --border2: rgba(255,255,255,0.14)
  static const Color borderLight = Color(0xFFE2E8F0);
}