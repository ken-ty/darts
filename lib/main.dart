

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'pages/home_page.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ダーツフィニッシュボード',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const DartsHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
