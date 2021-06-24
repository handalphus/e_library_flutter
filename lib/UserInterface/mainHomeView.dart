import 'package:animated_button/animated_button.dart';

import 'package:e_library_flutter/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'games.dart';
import 'movies.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final AuthService _authService = AuthService();

  final _user =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
  dynamic button_text_style = GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22));

    return
      Scaffold(
        appBar: AppBar(title: Text('eLibrary',style: button_text_style,),),

        body: Center(child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 20),

            Center(child:  Text('Welcome ' + (_user.displayName == null?"":_user.displayName),
              textDirection: TextDirection.ltr,style: GoogleFonts.inknutAntiqua(fontSize: 22),)),
            SizedBox(height: 20),
            Center( child:AnimatedButton(
                color: Colors.lightGreen,

                onPressed: () {
                  Navigator.of(context).pushNamed('/books');
                }, child: Text('Books',style: button_text_style,)

            ),),

            SizedBox(height: 20),
            Center(child:     AnimatedButton(
                color: Colors.lightGreen,
                onPressed: () {
                  Navigator.of(context).pushNamed('/movies');
                },
                child: Text('Movies',style:button_text_style,)),),

            SizedBox(height: 20),
            Center(child: AnimatedButton(
                color: Colors.lightGreen,
                onPressed: () {
                  Navigator.of(context).pushNamed('/games');
                }, child: Text('Games',style: button_text_style,)),),

            SizedBox(height: 20),
            Center(child:AnimatedButton(
                color: Colors.lightGreen,

                onPressed: () async {
                  await _authService.signOut();
                },
                child: Text('Sign out', style: button_text_style,)) ,),

          ],
        ), )


      );







  }
}
