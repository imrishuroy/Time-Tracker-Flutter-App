import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AppUser {
  final String uid;
  final String photoUrl;
  final String displayName;

  AppUser({
    @required this.uid,
    @required this.displayName,
    this.photoUrl,
  });
}

abstract class AuthBase {
  Stream<AppUser> get onAuthStateChanged;
  Future<AppUser> currentUser();
  Future<AppUser> signInAnounmously();
  Future<void> signOutUser();
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithFacebook();
  Future<AppUser> signInWithEmailAndPassword(String email, String password);
  Future<AppUser> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  AppUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return AppUser(
        uid: user.uid,
        photoUrl: user.photoURL,
        displayName: user.displayName,
      );
    }
  }

  @override
  Stream<AppUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<AppUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<AppUser> signInAnounmously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<AppUser> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_profile']);
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(result.accessToken.token),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOutUser() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
