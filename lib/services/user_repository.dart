import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<FirebaseUser> signUpWithEmailAndPassword(
      String username, String email, String password) async {
    var firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // update display name
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    await firebaseUser.updateProfile(userUpdateInfo);
    return _auth.currentUser();
  }

  Future signOut() async {
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    return _auth.currentUser() == null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }
}
