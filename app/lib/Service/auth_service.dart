import 'package:app/screen/Home.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Authservice{
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  

  static void siginUpUser(BuildContext context, String name, String email, String password)async{

    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if(signedInUser != null ){
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'email' : email,
          'name' : name,
          // 'password':password,
        });
        Navigator.pushReplacementNamed(context,Home.id);
      }

    }catch(e){
      print(e);
    }
  }
  static void logout(BuildContext context){
    _auth.signOut();
    Navigator.pushReplacementNamed(context,Login.id);

  }
  static void login (BuildContext context,String email ,String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email,password: password);
      Navigator.pushReplacementNamed(context,Home.id);
    }catch(e){
      print(e);
    }
    
  }

  
}