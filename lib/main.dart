
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:todo/firebase_service.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/auth_screen/auth_screen.dart';
import 'package:todo/screen/home_screen/home_screen.dart';
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
   Locale _locale = const Locale('en');

   void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
   void initState() {
    super.initState();
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
      locale: _locale,
      home:  AuthHandler(changeLanguage: changeLanguage),
    );
  }
}


class AuthHandler extends StatelessWidget {
  final Function(Locale) changeLanguage;
  const AuthHandler({super.key, required this.changeLanguage});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseService().userChanges, 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator( color: Colors.amber,));
        } else if (snapshot.hasData) {
          return HomeScreen(user: snapshot.data!, changeLanguage: changeLanguage);
        } else {
          return AuthScreen(changeLanguage: changeLanguage);
        }
      },
    );
  }
}