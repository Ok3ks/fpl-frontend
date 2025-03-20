import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBU0xCHvjrMs3iwhA03M4BBlunG9X0JzaU",
            authDomain: 'fpl-frontend.firebaseapp.com',
            projectId: 'fpl-frontend',
            storageBucket: 'fpl-frontend.firebasestorage.app',
            messagingSenderId: '249818130331',
            appId: '1:249818130331:web:ce0ad28a94d06607d7a33e',
            measurementId: 'G-RCXFD9EQ9E'));

    var auth = FirebaseAuth.instanceFor(app: app,);
    auth.setPersistence(Persistence.LOCAL);
    try {
      UserCredential firebaseUser = await auth
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

    final app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBU0xCHvjrMs3iwhA03M4BBlunG9X0JzaU",
            authDomain: 'fpl-frontend.firebaseapp.com',
            projectId: 'fpl-frontend',
            storageBucket: 'fpl-frontend.firebasestorage.app',
            messagingSenderId: '249818130331',
            appId: '1:249818130331:web:ce0ad28a94d06607d7a33e',
            measurementId: 'G-RCXFD9EQ9E'));

    final auth = FirebaseAuth.instanceFor(app: app,);
    auth.setPersistence(Persistence.LOCAL);

    try {
      UserCredential loggedInFirebaseUser =  await auth.signInWithEmailAndPassword(email: email, password: password);
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

  // Future<UserCredential?> getHistory(String participantID) async {
  //
  //   final history = await Uri.parse(
  //       "https://fantasy.premierleague.com/api/entry/$participantID/history/");
  //   final response = await http.read(history,
  //   headers: {
  //     'Access-Control-Allow-Origin': '*',
  //     'Access-Control-Allow-Methods': "OPTIONS, DELETE, GET, POST",
  //     'Access-Control-Allow-Headers': "Content-Type",
  //     'Access-Control-Allow-Credentials': "true"
  //   });
  //
  //   CollectionReference userDbRef = FirebaseFirestore.instance.collection("users/$participantID/");
  //   DocumentReference userId = await userDbRef.add({
  //     "history": {
  //       response
  //     }
  //   });
  // }

//TODO: Add LogOut
}

class ParticipantHistory {

  List<Map<String, dynamic>>? current;
  List<Map<String, dynamic>>? past;
  List<Map<String, dynamic>>? chips;

}