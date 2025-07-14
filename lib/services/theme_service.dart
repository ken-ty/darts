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

      case ColorTheme.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }

  bool get isDarkMode {
    switch (_currentTheme) {
      case ColorTheme.light:
        return false;
      case ColorTheme.dark:
        return true;
      case ColorTheme.system:
        // システム設定を確認する方法がないため、デフォルトでライト
        return false;
    }
  }
}
