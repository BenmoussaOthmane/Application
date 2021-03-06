import 'package:app/screen/Home.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:app/screen/category.dart';
import 'package:app/screen/detail_place.dart';
import 'package:app/screen/detailpageliste.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/onboarding.dart';
import 'package:app/screen/signup.dart';
import 'package:app/screen/splach.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
String uiiid;
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
    Widget _getscreenId(){
      return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context ,snapshot){
            if(snapshot.hasData){
              uiiid = snapshot.data.uid;
              print(snapshot.data);
              return Splach(userId: snapshot.data.uid);
            }else{
              return Category();
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
            Splach.id : (context) =>Splach(),
            Detailpageliste.id : (context) =>Detailpageliste(),
        
      },
    );
  }
}
