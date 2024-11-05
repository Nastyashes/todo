import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/login_screen/login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).registration),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration:  InputDecoration(
                    labelText: S.of(context).email,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide(width: 1))),
              )),
          const SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: S.of(context).password,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide(width: 1))),
                obscureText: true,
              )),
          const SizedBox(height: 16.0),
          ElevatedButton(
            child:  Text(S.of(context).registration),
            onPressed: () {},
          ),
          const SizedBox(height: 16.0),
          TextButton(
              onPressed: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: Text(S.of(context).login))
        ],
      ),
    );
  }
}
