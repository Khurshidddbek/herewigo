import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewigo/pages/home_page.dart';
import 'package:herewigo/pages/signup_page.dart';
import 'package:herewigo/services/auth_service.dart';
import 'package:herewigo/services/pref_service.dart';
import 'package:herewigo/services/utils_service.dart';

class SignInPage extends StatefulWidget {
  static final String id = 'signin_page';

  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  _doSignIn() {
    setState(() {
      _isLoading = true;
    });
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    AuthService.signInUser(context, email, password).then((firebaseUser) {
      _getFirebaseUser(firebaseUser);
    });
  }

  _getFirebaseUser(FirebaseUser firebaseUser) async {
    setState(() {
      _isLoading = false;
    });
    if(firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
    else {
      Utils.fireToast('Check email and password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextField : Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey,),

                  SizedBox(height: 10,),

                  // TextField : Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey,),

                  SizedBox(height: 10,),

                  // Button : Sign in
                  GestureDetector(
                    onTap: _doSignIn,
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('Sign in', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  // Button : Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, SignUpPage.id);
                        },
                        child: Text("Don't have an account? Sign Up", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
