import 'package:animated_button/animated_button.dart';
import 'package:e_library_flutter/authentication/register.dart';
import 'package:e_library_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _authService= AuthService();


  String mail;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

        title: Text('Log in',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle( color: Colors.white,fontSize: 22))),

      ),
      body: Container(
        child:Padding(
            padding: EdgeInsets.all(16.0),

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  TextFormField(
                    style: TextStyle( color: Colors.lightGreen,),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail_outline,  color: Colors.lightGreen,),
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

                      icon: Icon(Icons.vpn_key,  color: Colors.lightGreen,),
                      labelText: 'Password *',
                      labelStyle:  TextStyle( color: Colors.lightGreen,),
                    ),
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                    validator: (val)=>val.length<8?'Password is too short':null ,
                  ),
                  SizedBox(height: 20.0,),
                  AnimatedButton(
                    color: Colors.lightGreen,
                    child: Text('Log in',style:GoogleFonts.inknutAntiqua(textStyle: TextStyle( color: Colors.white,fontSize: 22))),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()){
                        dynamic res =await _authService.login( mail, password);
                        if(res==null){

                          Toast.show("Login unsuccessful", context, gravity: Toast.CENTER);

                        }
                        else{

                          _formKey.currentState?.reset();
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  AnimatedButton(
                    color: Colors.lightGreen,
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Register();
                      }));
                    },
                    child: Text('Create account',style: GoogleFonts.inknutAntiqua(textStyle: TextStyle(color: Colors.white,fontSize: 22)),),
                  )
                ],
              ),

            )


        ),
      ),
    );
  }
}
