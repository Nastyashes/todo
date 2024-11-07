import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';


class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.onAuth,
    required this.authButtonText,
    required this.emailController,
    required this.passwordController,
  });

  final VoidCallback onAuth;
  final String authButtonText;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: S.of(context).email,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1))),
            )),
        const SizedBox(height: 16.0),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: S.of(context).password,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1))),
              obscureText: true,
            )),
        const SizedBox(height: 16.0),
        
      /*  TextButton(
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(10))),
            onPressed: () {
             Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
            },
            child: Text(S.of(context).registration)) */
      ],
    );
  }
}
