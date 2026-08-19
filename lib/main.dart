import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'services/session_service.dart';

void main() {
  runApp(
  ChangeNotifierProvider(
    create: (_) => SessionService(),
    child: const AuraFocusApp(),
  ),
);
}

class AuraFocusApp extends StatelessWidget {
  const AuraFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuraFocus',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}