import 'package:e_library_flutter/UserInterface/books.dart';
import 'package:e_library_flutter/UserInterface/games.dart';
import 'package:e_library_flutter/UserInterface/mainHomeView.dart';
import 'package:e_library_flutter/UserInterface/movies.dart';
import 'package:e_library_flutter/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Add/books.dart';
import 'Add/games.dart';
import 'Add/movies.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.lightGreen,

      ),
      initialRoute: '/mainHome',
      routes: {

        '/mainHome':(context)=>MainHome(),
        '/books':(context)=>Books(),
        '/movies':(context)=>Movies(),
        '/games':(context)=>Games(),
        '/add/books':(context)=>AddBooks(),
        '/add/movies':(context)=>AddMovies(),
        '/add/games':(context)=>AddGames(),
      },


         );




  }
}

