import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef FirebaseUserCallback = void Function(FirebaseUser);

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;

  Future<FirebaseUser> signInAnonymously() async {
    _currentUser = await _firebaseAuth.signInAnonymously();
    return _currentUser;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    // TODO Google requires sha-1 config
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _currentUser = await _firebaseAuth.signInWithCredential(credential);
    return _currentUser;
  }

  Future<FirebaseUser> signInWithEmail(String email, String password) async {
    _currentUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _currentUser;
  }

  Future<FirebaseUser> signUpWithEmail(String username, String email, String password) async {
    FirebaseUser user =
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    /// Update displayName
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    user.updateProfile(userUpdateInfo);

    /// Update database
    final FirebaseDatabase _database = FirebaseDatabase.instance;
    _database.reference().child("users").child(user.uid).update(<String, String>{
      'username': username,
    });

    _currentUser = user;
    return _currentUser;
  }

  Future<void> sendPasswordResetEmail(email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    _currentUser = null;
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getCurrentUser() async {
    _currentUser = await _firebaseAuth.currentUser();
    return _currentUser;
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

final AuthService auth = AuthService();
