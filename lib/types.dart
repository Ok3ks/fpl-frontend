import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:fpl/dataprovider.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:env.dart'

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
  String? tier = "free";
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
    this.tier,
  });

  Future<UserCredential?> registerUser() async { 
    var app = await Firebase.initializeApp(
        // name: 'fpl-frontend',
        options: const FirebaseOptions(
        apiKey: Env.apiKey ?? '<API_KEY>',
          authDomain: Env.authDomain ?? "<AUTH_DOMAIN>",
          projectId: Env.projectId ?? "<PROJECT_ID>",
          storageBucket: Env.storageBucket ?? "<STORAGE-BUCKET>",
          messagingSenderId: Env.messagingSenderId ?? "<MESSENGER>",
          appId: Env.appId ?? "<APP_ID>",
          measurementId: Env.measurementId ?? "<MEASUREMENT_ID>"));

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
        "username": username,
        "tier": "free",
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
    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: Env.apiKey ?? '<API_KEY>',
          authDomain: Env.authDomain ?? "<AUTH_DOMAIN>",
          projectId: Env.projectId ?? "<PROJECT_ID>",
          storageBucket: Env.storageBucket ?? "<STORAGE-BUCKET>",
          messagingSenderId: Env.messagingSenderId ?? "<MESSENGER>",
          appId: Env.appId ?? "<APP_ID>",
          measurementId: Env.measurementId ?? "<MEASUREMENT_ID>"));
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
          apiKey: Env.apiKey ?? '<API_KEY>',
          authDomain: Env.authDomain ?? "<AUTH_DOMAIN>",
          projectId: Env.projectId ?? "<PROJECT_ID>",
          storageBucket: Env.storageBucket ?? "<STORAGE-BUCKET>",
          messagingSenderId: Env.messagingSenderId ?? "<MESSENGER>",
          appId: Env.appId ?? "<APP_ID>",
          measurementId: Env.measurementId ?? "<MEASUREMENT_ID>"));

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

  Future<bool?> logOut() async {
    final local = GetStorage();

    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: Env.apiKey ?? '<API_KEY>',
          authDomain: Env.authDomain ?? "<AUTH_DOMAIN>",
          projectId: Env.projectId ?? "<PROJECT_ID>",
          storageBucket: Env.storageBucket ?? "<STORAGE-BUCKET>",
          messagingSenderId: Env.messagingSenderId ?? "<MESSENGER>",
          appId: Env.appId ?? "<APP_ID>",
          measurementId: Env.measurementId ?? "<MEASUREMENT_ID>"));

    var auth = FirebaseAuth.instanceFor(
      app: app,
    );
    auth.setPersistence(Persistence.LOCAL);
    try {
      await auth.signOut();
      local.write("isLoggedIn", false);
      local.write("participant", {
        "email": "",
        "favoriteTeam": "",
        "participantId": "",
        "yearsPlayingFpl": "",
        "username": "",
      });
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<void> addLeague(League userLeague) async {
    """Adds user's associated leagueIds to Firestore and during session""";
    var app = await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: Env.apiKey ?? '<API_KEY>',
          authDomain: Env.authDomain ?? "<AUTH_DOMAIN>",
          projectId: Env.projectId ?? "<PROJECT_ID>",
          storageBucket: Env.storageBucket ?? "<STORAGE-BUCKET>",
          messagingSenderId: Env.messagingSenderId ?? "<MESSENGER>",
          appId: Env.appId ?? "<APP_ID>",
          measurementId: Env.measurementId ?? "<MEASUREMENT_ID>",
          databaseURL: "https://default.firebaseio.com"));

    var auth = FirebaseAuth.instanceFor(
      app: app,
    );
    auth.setPersistence(Persistence.LOCAL);

    //Save to users firestore collection
    if (participantId != null) {
      DocumentReference temp = userDbRef.doc(participantId);
      CollectionReference leagues = temp.collection("leagues");

      temp = leagues.doc(userLeague.leagueId.toString());
      temp.set({
        "id": userLeague.leagueId.toString(),
      }, SetOptions(merge: true)); // SetOptions caters to updates
    }
  }

//TODO: Provider which supplies most accessed element on login
}

class ParticipantHistory {
  List<Map<String, dynamic>>? current;
  List<Map<String, dynamic>>? past;
  List<Map<String, dynamic>>? chips;
}

class Message {
  String id;
  Participant? from;
  String timestamp;
  String text;

  Message(
      {required this.id,
      required this.from,
      required this.timestamp,
      required this.text});
}
