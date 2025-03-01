import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String email;
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
      print(email);
      print(password);
      //TODO: add additional info to firebaseUser with fireStore
      print(firebaseUser);
      if (firebaseUser.user != null) {
        await firebaseUser.user?.sendEmailVerification();
      }
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      print(e.code);
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
}
