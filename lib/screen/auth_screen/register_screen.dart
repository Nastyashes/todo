import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/auth_screen/auth_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                        builder: (context) => const AuthScreen()));
              },
              child: Text(S.of(context).login))
        ],
      ),
    );
  }
}
