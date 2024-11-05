import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/auth_screen/auth_screen.dart';
import 'package:todo/screen/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).login),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: S.of(context).email,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1))),
              )),
          const SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: S.of(context).password,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1))),
                obscureText: true,
              )),
          const SizedBox(height: 16.0),
          ElevatedButton(
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(10))),
            child: Text(S.of(context).login),
            onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));},
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
            ),
            icon: Image.asset(
              'assets/icons/google.png',
              width: 32,
            ),
            label: Text(S.of(context).signInGoogle),
            onPressed: () {},
          ),
          TextButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.all(10))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthScreen()));
              },
              child: Text(S.of(context).registration))
        ],
      ),
    );
  }
}
