import 'package:flutter/material.dart';
import 'package:todo/firebase_service.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/auth_screen/widget/auth_form.dart';
import 'package:todo/screen/home_screen/widget/language_dialog.dart';

class AuthScreen extends StatefulWidget {
  final Function(Locale) changeLanguage;
  const AuthScreen({super.key, required this.changeLanguage});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

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
    final buttonText = isLogin ? S.of(context).signIn : S.of(context).registr;
    final buttonSwapText =
        isLogin ? S.of(context).registration : S.of(context).login;

    return Scaffold(
      appBar: AppBar(
        actions: [
          LanguageDialog(changeLanguage: widget.changeLanguage),
        ],
        title: Text(buttonText),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthForm(
            onAuth: onAuth,
            authButtonText: buttonText,
            emailController: emailController,
            passwordController: passwordController,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double buttonWidth = constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.8;

              return Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: buttonWidth),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.all(20),
                        ),
                      ),
                      onPressed: onAuth,
                      child: Text(buttonText),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (isLogin) ...[
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: buttonWidth),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.all(15),
                          ),
                        ),
                        icon: Image.asset(
                          'assets/icons/google.png',
                          width: 32,
                        ),
                        label: Text(S.of(context).signInGoogle),
                        onPressed: () async {
                          await firebaseService.loginWithGoogle();
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: buttonWidth),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.all(15),
                          ),
                        ),
                        icon: Image.asset(
                          'assets/icons/facebook.png',
                          width: 32,
                        ),
                        label: Text(S.of(context).signInFacebook),
                        onPressed: () async {
                          await firebaseService.loginWithFacebook();
                        },
                      ),
                    ),
                  ],
                  TextButton(
                    child: Text('$buttonSwapText ?'),
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
