import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewigo/pages/signin_page.dart';
import 'package:herewigo/services/pref_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  /* Sign In User */
  //****************************************************************************
  static Future<FirebaseUser> signInUser(BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser firebaseUser = await _auth.currentUser();
      return firebaseUser;
    } catch (e) {
      print('Error SignInUser : $e');
    }
    return null;
  }
  //****************************************************************************


  /* Sign Up User */
  //****************************************************************************
  static Future<FirebaseUser> singUpUser(BuildContext context, String name, String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseUser firebaseUser = await _auth.currentUser();
      return firebaseUser;
    } catch (e) {
      print('Error SignUpUser : $e');
    }
    return null;
  }
  //****************************************************************************


  /* Sign Out User */
  //****************************************************************************
  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((_) {
      Navigator.pushReplacementNamed(context, SignInPage.id);
    });
  }
  //****************************************************************************
}