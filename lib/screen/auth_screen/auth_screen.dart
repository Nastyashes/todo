import 'package:flutter/material.dart';
import 'package:todo/firebase_service.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/auth_screen/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseService firebaseService = FirebaseService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onAuth = isLogin
        ? () => firebaseService.onLogin(
              email: emailController.text,
              password: passwordController.text,
            )
        : () => firebaseService.onRegister(
              email: emailController.text,
              password: passwordController.text,
            );
    final buttonText = isLogin ? 'Login' : 'Register';

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).login),
        ),
        body:Column(children: [ AuthForm(
          onAuth: onAuth,
          authButtonText: buttonText,
          emailController: emailController,
          passwordController: passwordController,
        ),
        TextButton(
              child: Text(buttonText),
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });})]),);
  }
}
