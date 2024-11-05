import 'package:flutter/material.dart';
import 'package:todo/screen/login_screen.dart';

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
        title: const Text('Auth'),
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
            child: const Text('Auth'),
            onPressed: () {},
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            icon: Image.asset(
              'assets/icons/google.png',
              width: 32,
            ),
            label: const Text('Sign in with Google'),
            onPressed: () {},
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Text('Sign in'))
        ],
      ),
    );
  }
}
