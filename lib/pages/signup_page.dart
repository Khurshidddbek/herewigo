import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewigo/pages/signin_page.dart';
import 'package:herewigo/services/auth_service.dart';
import 'package:herewigo/services/pref_service.dart';
import 'package:herewigo/services/utils_service.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static final String id = 'signup_page';

  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  _doSignUp() {
    setState(() {
      _isLoading = true;
    });

    String name = fullnameController.text.toString();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    AuthService.singUpUser(context, name, email, password).then((firebaseUser) {
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
    } else {
      Utils.fireToast('Check your information');
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
                  // TextField : Full Name
                  TextField(
                    controller: fullnameController,
                    decoration: InputDecoration(
                      hintText: 'Fullname',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey,),

                  SizedBox(height: 10,),

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

                  // Button : Sign up
                  GestureDetector(
                    onTap: _doSignUp,
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('Sign up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  // Button : Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, SignInPage.id);
                        },
                        child: Text("Already have an account? Sign In", style: TextStyle(fontWeight: FontWeight.bold),),
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
