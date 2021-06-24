import 'package:animated_button/animated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
class AddBooks extends StatefulWidget {
  @override
  _AddBooksState createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  final _referenceDatabase = FirebaseDatabase.instance.reference().child("books");
  final _formKey = GlobalKey<FormState>();
  String author;
  String title;
  String note;
  int grade;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(title: Text('Add book',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22))),
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
                      icon: Icon(Icons.person, color: Colors.white),
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
                      labelText: 'Author *',

                    ),
                    onChanged: (val){
                      setState(() {
                        author = val;
                      }
                      );
                    },
                    validator: (val)=>val.length>0?null:"Enter  the author",
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
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
                        dynamic res =await _referenceDatabase.push().set({ "title": title.trim(),"opinion":note, "isRead":false,  "userId" : FirebaseAuth.instance.currentUser.uid}).asStream();

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
