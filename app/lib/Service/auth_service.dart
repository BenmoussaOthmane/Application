import 'package:app/models/user_model.dart';
import 'package:app/screen/Home.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:app/screen/category.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class Authservice{
  static User currentUser;
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
   static String nameee = '' ;
   static String emaiiil='';
   static String imagee = '';
   static String id = '';
    

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
          'profileImageUrl' : '',
          // 'password':password,
        });
        doc = await _firestore.collection('/users').document(authResult.user.uid).get();

        Navigator.pushReplacementNamed(context,Category.id);
      }
        currentUser = User.fromDocument(doc);
        print(currentUser);
        Authservice.nameee = currentUser.name;
        Authservice.id= currentUser.id;
        print(nameee);
        emaiiil = currentUser.email;
        print(emaiiil);
        

    }catch(e){
      print(e);
    }
  }
  static void logout(BuildContext context){
    _auth.signOut();
    Navigator.pushReplacementNamed(context,Login.id);

  }
  static void login (BuildContext context,String email,String password) async {
    try{

      AuthResult authResult =await _auth.signInWithEmailAndPassword(email: email,password: password);
      doc = await _firestore.collection('/users').document(authResult.user.uid).get();
      Navigator.pushReplacementNamed(context,Home.id);
      
      currentUser = User.fromDocument(doc);
      Authservice.id= currentUser.id;
      Authservice.nameee=currentUser.name;
      Authservice.emaiiil=currentUser.email;
      Authservice.imagee=currentUser.profileImageUrl;

    }catch(e){
      print(e);
    }
    
  }

  
}