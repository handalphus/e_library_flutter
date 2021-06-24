import 'package:e_library_flutter/authentication/register.dart';
import 'package:e_library_flutter/authentication/signIn.dart';
import 'package:flutter/material.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggle(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {

      return MaterialApp(
          theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.lightGreen,

      ),
          home: SignIn());


  }
}
