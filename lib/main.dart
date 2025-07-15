import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';
import 'services/app_info_service.dart';
import 'services/language_service.dart';
import 'services/theme_service.dart';
import 'services/user_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeService _themeService = ThemeService.instance;
  final LanguageService _languageService = LanguageService.instance;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _themeService.addListener(_onThemeChanged);
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _themeService.removeListener(_onThemeChanged);
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await AppInfoService.initialize();
    await UserService.initialize();
    await _languageService.initialize();
    final currentUser = UserService.getCurrentUser();
    if (currentUser != null) {
      _themeService.setThemeFromUser(currentUser);
    }
  }

  void _onThemeChanged() {
    setState(() {});
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'outshotX',
      theme: _themeService.getThemeData(context),
      locale: _languageService.currentLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const DartsHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
