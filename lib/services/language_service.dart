import 'dart:ui' as ui;
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const String _systemLanguage = 'system';

  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  static LanguageService get instance => _instance;

  Locale? _currentLocale;
  Locale? get currentLocale => _currentLocale;

  // リスナー用のコールバック
  final List<VoidCallback> _listeners = [];

  // サポートされている言語のリスト
  static const List<Locale> supportedLocales = [
    Locale('ja', 'JP'),
    Locale('en', 'US'),
  ];

  // 言語名のマッピング
  static const Map<String, String> languageNames = {
    _systemLanguage: 'システム設定',
    'ja': '日本語',
    'en': 'English',
  };

  /// リスナーを追加
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// リスナーを削除
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// リスナーに通知
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// 初期化
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? _systemLanguage;
    await _updateLocale(languageCode);
  }

  /// 言語を設定
  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    await _updateLocale(languageCode);
    _notifyListeners(); // リスナーに通知
  }

  /// ロケールを更新
  Future<void> _updateLocale(String languageCode) async {
    if (languageCode == _systemLanguage) {
      // システム言語を使用
      final systemLocale = ui.PlatformDispatcher.instance.locale;
      if (supportedLocales.any(
        (locale) => locale.languageCode == systemLocale.languageCode,
      )) {
        _currentLocale = systemLocale;
      } else {
        // システム言語がサポートされていない場合は日本語をデフォルトに
        _currentLocale = const Locale('ja', 'JP');
      }
    } else {
      _currentLocale = Locale(languageCode);
    }
  }

  /// 現在の言語コードを取得
  Future<String> getCurrentLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? _systemLanguage;
  }

  /// 言語名を取得
  String getLanguageName(String languageCode) {
    return languageNames[languageCode] ?? languageCode;
  }

  /// サポートされている言語のリストを取得
  List<String> getSupportedLanguageCodes() {
    return [
      _systemLanguage,
      ...supportedLocales.map((locale) => locale.languageCode),
    ];
  }

  /// システム言語が設定されているかチェック
  Future<bool> isSystemLanguage() async {
    final languageCode = await getCurrentLanguageCode();
    return languageCode == _systemLanguage;
  }
}
