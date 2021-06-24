import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class AddMovies extends StatefulWidget {
  @override
  _AddMoviesState createState() => _AddMoviesState();
}

class _AddMoviesState extends State<AddMovies> {
  final _referenceDatabase = FirebaseDatabase.instance.reference().child("movies");
  final _formKey = GlobalKey<FormState>();
  String director;
  String title;
  String note;
  String yearOfRelease;
  int grade;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Add movie',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22))),
      ),
      body: Container(
        child:Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child:Column(
                children: [

                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.movie_creation_outlined, color: Colors.white),
                      labelText: 'Title *',

                    ),
                    onChanged: (val){
                      setState(() {
                        title = val;
                      }
                      );
                    },
                    validator: (val)=>val.length>0?null:"Title is too short",
                  ),

                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      labelText: 'Director *: ',

                    ),
                    onChanged: (val){
                      setState(() {
                        director = val;
                      }
                      );
                    },
                    validator: (val)=>val.length>0?null:"Enter the director",
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today, color: Colors.white),
                      labelText: 'Year of release *: ',

                    ),
                    onChanged: (val){
                      setState(() {
                        yearOfRelease = val;
                      }
                      );
                    },
                    validator: (val)=>val.length>0?null:"Enter the year of release",
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today, color: Colors.white),
                      labelText: 'Note: ',

                    ),
                    onChanged: (val){
                      setState(() {
                        note = val;
                      }
                      );
                    },

                  ),
                  SizedBox(height: 20.0,),
                  AnimatedButton(
                    color: Colors.lightGreen,
                    child: Text('Add',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22))),

                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        dynamic res =await _referenceDatabase.push().set({ "title": title.trim(),"director":director.trim(),"year_of_release":int.parse(yearOfRelease), "note":note, "isWatched":false, "opinion":"", "userId" : FirebaseAuth.instance.currentUser.uid}).asStream();
                        if(res==null){
                          Toast.show("Adding unsuccessful", context, gravity: Toast.CENTER);

                        }
                        else{
                          Toast.show("Added successfully", context, gravity: Toast.CENTER);
                          _formKey.currentState?.reset();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
