import 'package:animated_button/animated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  final _referenceDatabase = FirebaseDatabase.instance.reference().child("games");
  final _user =FirebaseAuth.instance.currentUser;
  String _note;
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _dbTable = FirebaseDatabase.instance.reference().child('games');
    return Scaffold(
        appBar: AppBar(title: Text('Games',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22))),),
        body: Column(
          children: [
            Flexible(child: FirebaseAnimatedList(
              shrinkWrap: false,
              query: _dbTable.orderByChild("userId").equalTo(_user.uid),
              sort: (a,b){
                if(a.value["isPlayed"]){
                  return 1;
                }
                else{
                  return -1;
                }

              },
              itemBuilder:(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){


                return
                  Container(

                      child: Card(
                          child:Container(

                              child:ExpansionTile(

                                trailing:
                                Container(

                                  child:Column(
                                    children: [
                                      Flexible(child: Text('Is played?',style: GoogleFonts.inknutAntiqua(fontWeight: FontWeight.w100)),),
                                      Flexible(child: Switch(
                                        value: snapshot.value['isPlayed'],
                                        onChanged:(val)
                                        {_dbTable.child(snapshot.key).update({"isPlayed":!snapshot.value['isPlayed']}); },),),


                                    ],),)
                                ,
                                title: Text(snapshot.value['title'].toString(),style: GoogleFonts.inknutAntiqua(fontSize: 20),),
                                
                                children: <Widget>[
                                  Text((snapshot.value['opinion']==null?'':snapshot.value['opinion']),textAlign: TextAlign.left,style: GoogleFonts.inknutAntiqua()),
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
                                    }, child: Text('Add note',style: GoogleFonts.inknutAntiqua(color: Colors.white))
                                    )
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

              Navigator.of(context).pushNamed('/add/games');
            }, child: Text('Add game',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22)))),
            SizedBox(height: 10,),
          ],
        )
    );
  }
}
