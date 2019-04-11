import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef FirebaseUserCallback = void Function(FirebaseUser);

class Auth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInAnonymously() async {
    return await _firebaseAuth.signInAnonymously();
  }

  Future<FirebaseUser> signInWithGoogle() async {
    // TODO Google require sha-1 config
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<FirebaseUser> signInWithEmail(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<FirebaseUser> signUpWithEmail(
      String username, String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    /// Update displayName
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    user.updateProfile(userUpdateInfo);

    /// Update database
    final FirebaseDatabase _database = FirebaseDatabase.instance;
    _database
        .reference()
        .child("users")
        .child(user.uid)
        .update(<String, String>{
      'username': username,
    });

    return user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
