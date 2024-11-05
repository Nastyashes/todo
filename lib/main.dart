import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/login_screen.dart';
import 'package:todo/theme.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            minWidth: 500,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(375, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(500, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
          ),

      theme: const MaterialTheme(TextTheme()).light(),
      darkTheme:const MaterialTheme(TextTheme()).dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
      home: const LoginScreen(),
    );
  }
}


