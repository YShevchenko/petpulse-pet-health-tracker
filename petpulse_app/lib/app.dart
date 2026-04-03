import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'domain/services/notification_service.dart';
import 'presentation/screens/home_screen.dart';

class PetPulseApp extends StatelessWidget {
  const PetPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetPulse',
      debugShowCheckedModeBanner: false,
      navigatorKey: NotificationService().navigatorKey,
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
        Locale('es'),
        Locale('uk'),
      ],
      home: const HomeScreen(),
    );
  }
}
