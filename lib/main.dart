import 'package:e_library_flutter/UserInterface/books.dart';
import 'package:e_library_flutter/services/auth.dart';
import 'package:e_library_flutter/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp(  ));
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(

      value: AuthService().user,
     child: Wrapper(),

    );


  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Container(
        child: Text('loading...',textDirection: TextDirection.ltr),
      )
    );

  }
}
// child: FutureBuilder(
// // Initialize FlutterFire:
// future: _init,
// builder: (context, snapshot) {
// // Check for errors
//
//
// // Once complete, show your application
// if (snapshot.connectionState == ConnectionState.done) {
// return Wrapper();
// }
//
// // Otherwise, show something whilst waiting for initialization to complete
// return Loading();
// },
// ),