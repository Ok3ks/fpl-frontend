import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<UserCredential> signInWithGoogle() async {
// Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

// Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

// Or use signInWithRedirect
// return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

class accountWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
            onPressed: () async {
              await signInWithGoogle();
            },
            icon: Icon(Icons.account_circle_sharp, color: Colors.black));
  }
}