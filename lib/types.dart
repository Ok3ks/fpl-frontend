import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:fpl/dataprovider.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class League {
  String? name;
  double? leagueId;

  League({this.name, required this.leagueId});
}

class Participant {
  String email;
  String? username;
  String? favoriteTeam;
  String? participantId;
  String? yearsPlayingFpl;
  String? location;
  String? password;
  String? error;
  Map<String, dynamic>? history;

  Participant({
    required this.email,
    this.favoriteTeam,
    this.username,
    this.participantId,
    this.yearsPlayingFpl,
    this.location,
    this.password,
    this.history,
  });

  Future<UserCredential?> registerUser() async {
    await dotenv.load(fileName: ".env");
    var app = await Firebase.initializeApp(
        // name: 'fpl-frontend',
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBU0xCHvjrMs3iwhA03M4BBlunG9X0JzaU',
            authDomain: 'fpl-frontend.firebaseapp.com',
            projectId: 'fpl-frontend',
            storageBucket: 'fpl-frontend.firebasestorage.app',
            messagingSenderId: "249818130331",
            appId: "1:249818130331:web:ce0ad28a94d06607d7a33e",
            measurementId: "G-RCXFD9EQ9E",
            databaseURL: "https://default.firebaseio.com")

    );


    var auth = FirebaseAuth.instanceFor(
      app: app,
    );
    auth.setPersistence(Persistence.LOCAL);

    try {
      UserCredential firebaseUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password ?? "VRBWX6k3gZ");
      //TODO: Opportunity to add more information as drawn from FPL, into Firestore
      DocumentReference temp = userDbRef.doc(participantId);

      await temp.set({
        "email": email,
        "status": "onboarding",
        "participantId": participantId,
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

  Future<dynamic> retrieveUser(String password) async {
    await dotenv.load(fileName: ".env");
    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBU0xCHvjrMs3iwhA03M4BBlunG9X0JzaU',
            authDomain: 'fpl-frontend.firebaseapp.com',
            projectId: 'fpl-frontend',
            storageBucket: 'fpl-frontend.firebasestorage.app',
            messagingSenderId: "249818130331",
            appId: "1:249818130331:web:ce0ad28a94d06607d7a33e",
            measurementId: "G-RCXFD9EQ9E",
            databaseURL: "https://default.firebaseio.com"));

    var auth = FirebaseAuth.instanceFor(
      app: app,
    );
    auth.setPersistence(Persistence.LOCAL);
    try {
      UserCredential loggedInFirebaseUser = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      error = '';

      return loggedInFirebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        error = e.code;
        return error;
      }
    }
    return "Error with Firebase Auth";
  }

  Future<bool?> sendEmailLink() async {
    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBU0xCHvjrMs3iwhA03M4BBlunG9X0JzaU',
            authDomain: 'fpl-frontend.firebaseapp.com',
            projectId: 'fpl-frontend',
            storageBucket: 'fpl-frontend.firebasestorage.app',
            messagingSenderId: "249818130331",
            appId: "1:249818130331:web:ce0ad28a94d06607d7a33e",
            measurementId: "G-RCXFD9EQ9E",
            databaseURL: "https://default.firebaseio.com")
    );

    var auth = FirebaseAuth.instanceFor(
      app: app,
    );
    auth.setPersistence(Persistence.LOCAL);
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<void> addLeague(League userLeague) async {
    """Adds user's associated leagueIds to Firestore and during session""";
    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBU0xCHvjrMs3iwhA03M4BBlunG9X0JzaU',
            authDomain: 'fpl-frontend.firebaseapp.com',
            projectId: 'fpl-frontend',
            storageBucket: 'fpl-frontend.firebasestorage.app',
            messagingSenderId: "249818130331",
            appId: "1:249818130331:web:ce0ad28a94d06607d7a33e",
            measurementId: "G-RCXFD9EQ9E",
            databaseURL: "https://default.firebaseio.com"));

    var auth = FirebaseAuth.instanceFor(
      app: app,
    );
    auth.setPersistence(Persistence.LOCAL);
    //Save to users firestore collection
    if (participantId != null) {
      CollectionReference userLeagueDbRef =
          FirebaseFirestore.instance.collection("users");

      DocumentReference temp = userLeagueDbRef.doc(participantId);
      CollectionReference leagues = await temp.collection("leagues");

      temp = leagues.doc(userLeague.leagueId.toString());
      temp.set({"id": userLeague.leagueId},
          SetOptions(merge: true)); // SetOptions caters to updates
    }
  }

//TODO: Add LogOut

//TODO: Provider which supplies most accessed element on login
}

class ParticipantHistory {
  List<Map<String, dynamic>>? current;
  List<Map<String, dynamic>>? past;
  List<Map<String, dynamic>>? chips;
}
