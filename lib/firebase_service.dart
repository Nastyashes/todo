import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();

  factory FirebaseService() => _singleton;

  FirebaseService._internal();

  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<UserCredential?> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final String token = accessToken.tokenString;
        final facebookAuthCredential = FacebookAuthProvider.credential(token);

        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else {
        log("Facebook login failed: ${result.message}");
        return null;
      }
    } catch (e) {
      log("Error during Facebook sign-in: $e");
      return null;
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      return await FirebaseAuth.instance.signInWithCredential(cred);
    } catch (e) {
      log("Error during Google sign-in: $e");
    }
    return null;
  }

  Stream<User?> get userChanges => auth.authStateChanges();

  onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }

  onLogin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      log('User signed in: $credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }


  onRegister({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User registered: $credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  logOut() async {
    await auth.signOut();
  }

  onVerifyEmail() async {
    await currentUser?.sendEmailVerification();
  }

  
  Future<void> addPasswordToAccount(String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        
        await user.updatePassword(password);
        log("Password has been set for the user");
      } else {
        log("No user is currently logged in.");
      }
    } catch (e) {
      log("Error while setting password: $e");
    }
  }
}
