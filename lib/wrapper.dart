import 'package:e_library_flutter/authentication/authenticate.dart';
import 'package:e_library_flutter/UserInterface/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
