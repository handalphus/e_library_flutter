
import 'package:animated_button/animated_button.dart';
import 'package:e_library_flutter/authentication/signIn.dart';
import 'package:e_library_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _authService= AuthService();

  String name;
  String mail;
  String password;
  String repeatedPassword;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(

          title: Text('Create account',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle( color: Colors.white,fontSize: 22))),

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
                      style: TextStyle( color: Colors.lightGreen,),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person,  color: Colors.lightGreen,),
                        labelText: 'Name *',
                        labelStyle:  TextStyle( color: Colors.lightGreen,),
                      ),
                      onChanged: (val){
                        setState(() {
                          name = val;
                        }
                        );
                      },
                      validator: (val)=>val.length>0?null:"Name is too short",
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle( color: Colors.lightGreen,),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email_outlined,  color: Colors.lightGreen,),
                        labelText: 'Email *',
                        labelStyle:  TextStyle( color: Colors.lightGreen,),
                      ),
                      onChanged: (val){
                        setState(() {
                          mail = val;
                        }
                        );
                      },
                      validator: (val){
                        String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regExp = new RegExp(pattern);
                        return regExp.hasMatch(val)?null:'Email is incorrect';
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle( color: Colors.lightGreen,),
                      obscureText: true,
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          labelStyle:  TextStyle( color: Colors.lightGreen,),
                          icon: Icon(Icons.vpn_key,  color: Colors.lightGreen,),
                          labelText: 'Password *'
                      ),
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val){
                        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        RegExp regExp = new RegExp(pattern);
                        return regExp.hasMatch(val)?null:'Password too weak';
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle( color: Colors.lightGreen,),
                      obscureText: true,
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          labelStyle:  TextStyle( color: Colors.lightGreen,),
                          icon: Icon(Icons.vpn_key,  color: Colors.lightGreen,),
                          labelText: 'Repeat password *'
                      ),
                      onChanged: (val){
                        setState(() {
                          repeatedPassword = val;
                        });
                      },
                      validator: (val){
                        if(val == password) {
                          return null;
                        }
                        else {
                          return "Passwords don't match";
                        }
                      },
                    ),
                    SizedBox(height: 20.0,),
                    AnimatedButton(
                      color: Colors.lightGreen,
                      child: Text('Register',style: GoogleFonts.inknutAntiqua(color: Colors.white,fontSize: 22),),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic res =await _authService.register( mail, password,name);
                          if(res==null){
                            Toast.show("Register unsuccessful", context, gravity: Toast.CENTER);

                          }
                          else{
                            Toast.show("Register successful", context, gravity: Toast.CENTER);
                            _formKey.currentState?.reset();
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    AnimatedButton(
                      color: Colors.lightGreen,
                      onPressed:(){
                        Navigator.pop(context);
                      },
                      child: Text('Back to login',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22)),),
                    )
                  ],
                ),
              ),
            ),
          ),
        )



    );
  }
}
