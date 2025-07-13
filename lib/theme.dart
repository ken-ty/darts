import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// DARTS LIVE の的の色
// 青: #0066CC (ブルー)
// 赤: #CC0000 (レッド)
// 緑: #00CC00 (グリーン)
// 黒: #000000 (ブラック)
// 白: #FFFFFF (ホワイト)

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF0066CC), // ブルー
    secondary: const Color(0xFFCC0000), // レッド
    tertiary: const Color(0xFF00CC00), // グリーン
    surface: const Color(0xFFFFFFFF), // ライトグレー
    error: const Color(0xFFCC0000), // レッド
    onPrimary: const Color(0xFFFFFFFF), // ホワイト
    onSecondary: const Color(0xFFFFFFFF), // ホワイト
    onTertiary: const Color(0xFF000000), // ブラック
    onSurface: const Color(0xFF000000), // ブラック
    onError: const Color(0xFFFFFFFF), // ホワイト
    outline: const Color(0xFF000000), // ブラック
    surfaceContainerHighest: const Color(0xFFE0E0E0), // ライトグレー
    onSurfaceVariant: const Color(0xFF000000), // ブラック
  ),
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF000000),
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 45.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF000000),
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF0066CC),
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF000000),
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF0066CC),
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFCC0000),
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF000000),
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF0066CC),
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF000000),
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF000000),
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF000000),
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF000000),
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF000000),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF000000),
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF000000),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF0066CC),
    foregroundColor: const Color(0xFFFFFFFF),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0066CC),
      foregroundColor: const Color(0xFFFFFFFF),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFFFFFFFF),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF0066CC), // ブルー
    secondary: const Color(0xFFCC0000), // レッド
    tertiary: const Color(0xFF00CC00), // グリーン
    surface: const Color(0xFF1A1A1A), // ブラック
    error: const Color(0xFFCC0000), // レッド
    onPrimary: const Color(0xFFFFFFFF), // ホワイト
    onSecondary: const Color(0xFFFFFFFF), // ホワイト
    onTertiary: const Color(0xFF000000), // ブラック
    onSurface: const Color(0xFFFFFFFF), // ホワイト
    onError: const Color(0xFFFFFFFF), // ホワイト
    outline: const Color(0xFFFFFFFF), // ホワイト
    surfaceContainerHighest: const Color(0xFF2A2A2A), // ダークグレー
    onSurfaceVariant: const Color(0xFFFFFFFF), // ホワイト
  ),
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 45.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF0066CC),
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF0066CC),
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFCC0000),
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFFFFFFF),
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF0066CC),
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFFFFFFF),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFFFFFFF),
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFFFFFFF),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF000000),
    foregroundColor: const Color(0xFFFFFFFF),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0066CC),
      foregroundColor: const Color(0xFFFFFFFF),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF1A1A1A),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
