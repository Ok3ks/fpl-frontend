import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<UserCredential> signInWithGoogle() async {
// Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

// Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await signInWithGoogle();
        },
        icon: const Icon(Icons.account_circle_sharp, color: Colors.black));
  }
}

class VerificationWidget extends StatelessWidget {
  const VerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return IconButton(
        onPressed: () async {
          await user?.sendEmailVerification();
        },
        icon: const Icon(Icons.verified_user, color: Colors.black));
  }
}
