import 'package:animated_button/animated_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Books extends StatefulWidget {
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  final _referenceDatabase = FirebaseDatabase.instance.reference().child("books");
  final _user =FirebaseAuth.instance.currentUser;
  String _note;
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   final _dbTable = FirebaseDatabase.instance.reference().child('books');

    return
      Scaffold(
          resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Books',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22)),),
      ),
      body: Column(
        children: [
          Flexible(child: FirebaseAnimatedList(
            shrinkWrap: false,
            query: _dbTable.orderByChild("userId").equalTo(_user.uid),
            sort: (a,b){
              if(a.value["isRead"]){
                return 1;
              }
              else{
                return -1;
              }

            },
            itemBuilder:(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){

           ;
              return
             Container(

               child: Card(
                    child:Container(

                  child:ExpansionTile(

                      trailing:
                          Container(

                      child:
                      Column(
                        children: [
                          Flexible(child: Text('Is read?',style: GoogleFonts.inknutAntiqua(fontWeight: FontWeight.w100)))
                          ,
                          Flexible(child:     Switch(
                            value: snapshot.value['isRead'],
                            onChanged:(val)
                            {_dbTable.child(snapshot.key).update({"isRead":!snapshot.value['isRead']}); },),)

                        ],)
                      )
                   ,
                      title: Text(snapshot.value['title'].toString(),style: GoogleFonts.inknutAntiqua(fontSize: 20),),
                      subtitle: Text(snapshot.value['author'].toString(),style: GoogleFonts.inknutAntiqua(fontWeight: FontWeight.w100),),
                      children: <Widget>[

                        Text((snapshot.value['opinion']==null?'':snapshot.value['opinion']),textAlign: TextAlign.left,style: GoogleFonts.inknutAntiqua(),),
                        Form(child:
                        Column(children:[
                        TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(

                            labelText: 'Note',

                          ),
                          onChanged: (val){

                            setState(() {
                              _note =  val;

                            }
                            );
                          },),
                            SizedBox(height: 10,),
                            AnimatedButton(
                                color: Colors.lightGreen,
                                width: 120,
                                height: 40,
                                onPressed: (){
                              print(_note);

                              String note = snapshot.value['opinion']==null?'':snapshot.value['opinion'];
                              _dbTable.child(snapshot.key).update({"opinion":note +"\n"+ _note.toString()});
                              _controller.clear();
                            }, child: Text('Add note',style: GoogleFonts.inknutAntiqua(color: Colors.white),)
                            ),
                          SizedBox(height: 10,),
                       ] ),
                        )
                      ],
              ))));
            } ,
          )),
          SizedBox(height: 10,),
          AnimatedButton(
              color: Colors.lightGreen,
              onPressed: (){

            Navigator.of(context).pushNamed('/add/books');
          }, child: Center(child: Text('Add book',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22)),))),
          SizedBox(height: 10,),

        ],
      ),

    );
  }
}
// _referenceDatabase.push().set({"author":"tolkien"}).asStream();