import 'package:flutter/material.dart';
import 'package:todo/screen/auth_screen.dart';

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
        title: const Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              )),
          const SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                obscureText: true,
              )),
          const SizedBox(height: 16.0),
          ElevatedButton(
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(10))),
            child: const Text('Login'),
            onPressed: () {},
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
            label: const Text('Sign in with Google'),
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
              child: const Text('Registred'))
        ],
      ),
    );
  }
}
