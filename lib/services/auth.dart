import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

    final FirebaseAuth _auth = FirebaseAuth.instance;

  User currentUser;
    Stream<User> get user {


      return _auth.authStateChanges();
    }

    Future signInAnon() async{

      try{
       UserCredential res =  await _auth.signInAnonymously();
       User user = res.user;
       print(user);
       return user;
      }
      catch(e){
        print(e.toString());
        return null;
      }

    }

    Future signOut() async{

      try{
        return await _auth.signOut();
      }
      catch(e){
        print(e.toString());
        return null;
      }
    }

    Future register(String email, String password,String name) async{
      try {
        print(email);
        UserCredential res = await _auth.createUserWithEmailAndPassword(email:email.trim(),password:password.trim());
        User user = res.user;



        await _auth.currentUser.updateProfile( displayName:name, photoURL:"");
        user =  _auth.currentUser;
        print(user);
        return user;
      }
      catch(e){
        print(e.toString());
        return null;
      }
    }

    Future login(String email, String password) async{
      try{
        UserCredential res = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User user = res.user;
        currentUser = res.user;
        print(user);
        return user;
      }
      catch(e){
        print(e.toString());
        return null;
      }
    }
}