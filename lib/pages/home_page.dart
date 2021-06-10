import 'package:flutter/material.dart';
import 'package:herewigo/pages/signin_page.dart';
import 'package:herewigo/services/auth_service.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Home', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          color: Colors.red,
          child: Text('Logout', style: TextStyle(color: Colors.white),),
          onPressed: () {
            AuthService.signOutUser(context);
            Navigator.pushReplacementNamed(context, SignInPage.id);
          },
        ),
      ),
    );
  }
}
