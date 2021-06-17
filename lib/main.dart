import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewigo/pages/detail_page.dart';
import 'package:herewigo/pages/home_page.dart';
import 'package:herewigo/pages/signin_page.dart';
import 'package:herewigo/pages/signup_page.dart';
import 'package:herewigo/services/pref_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _startPage() {
    return StreamBuilder<FirebaseUser> (
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        DetailPage.id: (context) => DetailPage(),
      },
    );
  }
}