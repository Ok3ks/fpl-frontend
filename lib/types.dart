import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:fpl/dataprovider.dart";

class User {
  String email;
  String? username;
  String? favoriteTeam;
  String? fplUrl;
  String? yearsPlayingFpl;
  String? location;
  String? password;
  String? error;

  User(
      {required this.email,
      this.favoriteTeam,
      this.username,
      this.fplUrl,
      this.yearsPlayingFpl,
      this.location,
      this.password});

  Future<UserCredential?> registerUser() async {
    try {
      UserCredential firebaseUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: password ?? "VRBWX6k3gZ");
      //TODO: add additional info to firebaseUser with fireStore
      DocumentReference userId = await userDbRef.add({
        "email": email,
        "status": "onboarding",
        "fplUrl": fplUrl,
        "yearsPlayingFpl": yearsPlayingFpl,
        "location": location,
        "favoriteTeam": favoriteTeam,
        // "username":username,
      });
      if (firebaseUser.user != null) {
        await firebaseUser.user?.sendEmailVerification();
      }
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak';
        return null;
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
        return null;
      }
      return null;
    }
  }

  Future<UserCredential?> retrieveUser(String password) async {
    try {
      UserCredential loggedInFirebaseUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return loggedInFirebaseUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //TODO: Add LogOut

  //TODO: Add FireStore to save other user's information
}
