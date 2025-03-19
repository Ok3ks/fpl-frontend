import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:fpl/dataprovider.dart";
import 'package:http/http.dart' as http;

class Participant {
  String email;
  String? username;
  String? favoriteTeam;
  String? fplUrl;
  String? yearsPlayingFpl;
  String? location;
  String? password;
  String? error;
  Map<String, dynamic>? history;

  Participant({required this.email,
    this.favoriteTeam,
    this.username,
    this.fplUrl,
    this.yearsPlayingFpl,
    this.location,
    this.password,
    this.history
  });

  Future<UserCredential?> registerUser() async {
    try {
      UserCredential firebaseUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password ?? "VRBWX6k3gZ");
      //TODO: Opportunity to add more information as drawn from FPL, into Firestore
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
      error = '';
      return loggedInFirebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        error = e.code;
        return null;
      }
    }

    return null;
  }

  Future<UserCredential?> getHistory(String participantID) async {

    final history = await Uri.parse(
        "https://fantasy.premierleague.com/api/entry/$participantID/history/");
    final response = await http.read(history);
    DocumentReference userId = await userDbRef.add({
      "history": {
        response
      }
    });
  }

//TODO: Add LogOut
}

class ParticipantHistory {

  List<Map<String, dynamic>>? current;
  List<Map<String, dynamic>>? past;
  List<Map<String, dynamic>>? chips;

}