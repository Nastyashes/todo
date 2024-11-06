
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:todo/firebase_service.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/auth_screen/auth_screen.dart';
import 'package:todo/screen/entities/user.dart';
import 'package:todo/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseService().onListenUser((user) {
  WidgetsBinding.instance.addPostFrameCallback((_) { 
    if (user == null) {
      Navigator.pushReplacement(
        kNavigatorKey.currentContext!,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    } else {
      Navigator.pushReplacement(
        kNavigatorKey.currentContext!,
        MaterialPageRoute(builder: (_) => UserInfoScreen(user: user)),
      );
    }
  });
});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: kNavigatorKey,
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
      darkTheme: const MaterialTheme(TextTheme()).dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const AuthScreen(),
    );
  }
}
