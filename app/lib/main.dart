import 'package:app/screen/Home.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:app/screen/category.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/onboarding.dart';
import 'package:app/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

    Widget _getscreenId(){
      return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context ,snapshot){
            if(snapshot.hasData){
              print(snapshot.data);
              return Home(userId: snapshot.data.uid);
            }else{
              return Onboarding();
            }
        }
      );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     debugShowCheckedModeBanner: false,
      home: _getscreenId(),
      routes: {
        
        Login.id : (context) => Login(),
        Signup.id : (context) => Signup(),
        Home.id :(context) =>Home(),
        UPdateusers.id : (context) => UPdateusers(),
        Category.id : (context) => Category(),
        
      },
    );
  }
}
