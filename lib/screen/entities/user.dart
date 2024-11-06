import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_service.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User name: ${user.displayName}'),
            Text('User email: ${user.email}'),
            StreamBuilder<User?>(
              stream: FirebaseService().auth.userChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.data == null) {
                  return const Text('User not found');
                }
                final user = snapshot.data!;
                user.reload();
                if (user.emailVerified) {
                  return Text('Email: is Verify: ${user.emailVerified}');
                } else {
                  return Column(
                    children: [
                      Text('Email: is Verify: ${user.emailVerified}'),
                      TextButton(
                        onPressed: () {
                          FirebaseService().onVerifyEmail();
                        },
                        child: const Text('Verify Email'),
                      ),
                    ],
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                FirebaseService().logOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}