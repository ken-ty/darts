import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../theme.dart';

class ThemeService extends ChangeNotifier {
  static ThemeService? _instance;
  static ThemeService get instance => _instance ??= ThemeService._();

  ThemeService._();

  ColorTheme _currentTheme = ColorTheme.system;

  ColorTheme get currentTheme => _currentTheme;

  void setTheme(ColorTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void setThemeFromUser(UserProfile user) {
    _currentTheme = user.colorTheme;
    notifyListeners();
  }

  ThemeData getThemeData(BuildContext context) {
    switch (_currentTheme) {
      case ColorTheme.light:
        return lightTheme;
      case ColorTheme.dark:
        return darkTheme;
      case ColorTheme.dartsLive:
        return _getDartsLiveTheme();
      case ColorTheme.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }

  ThemeData _getDartsLiveTheme() {
    // DARTS LIVE専用テーマ（より鮮やかな色使い）
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0066CC), // ブルー
        secondary: Color(0xFFCC0000), // レッド
        tertiary: Color(0xFF00CC00), // グリーン
        surface: Color(0xFF000000), // ブラック
        error: Color(0xFFCC0000), // レッド
        onPrimary: Color(0xFFFFFFFF), // ホワイト
        onSecondary: Color(0xFFFFFFFF), // ホワイト
        onTertiary: Color(0xFF000000), // ブラック
        onSurface: Color(0xFFFFFFFF), // ホワイト
        onError: Color(0xFFFFFFFF), // ホワイト
        outline: Color(0xFFFFFFFF), // ホワイト
        surfaceContainerHighest: Color(0xFF1A1A1A), // ダークグレー
        onSurfaceVariant: Color(0xFFFFFFFF), // ホワイト
      ),
      brightness: Brightness.dark,
      textTheme: lightTheme.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: lightTheme.textTheme.titleLarge?.copyWith(
          color: const Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
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
  }

  bool get isDarkMode {
    switch (_currentTheme) {
      case ColorTheme.light:
        return false;
      case ColorTheme.dark:
      case ColorTheme.dartsLive:
        return true;
      case ColorTheme.system:
        // システム設定を確認する方法がないため、デフォルトでライト
        return false;
    }
  }
}
