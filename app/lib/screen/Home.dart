import 'package:app/Service/auth_service.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screen/favorit.dart';
import 'package:app/screen/feed.dart';
import 'package:app/screen/liste.dart';
import 'package:app/screen/location.dart';
import 'package:app/screen/profile.dart';
import 'package:app/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  final String userId;
  
  Home({this.userId});
  static final id = 'home';
  static String y = '';
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  int pageIndex = 0;
  final Feed _feed = Feed();
  final Favorit _favorit = Favorit();
  final Location _location = Location();
  final Liste _liste = Liste();
  final Profile _profile = Profile( );
  String email,password;
  Widget _showpage = new Feed();
  Widget _pageChooser(int page){
    switch(page){
      case 0:
      return _feed;
      break; 
      case 1:
      return _favorit;
      break; 
      case 2:
      return _location;
      break; 
      case 3:
      return _liste;
      break; 
      case 4:
      return _profile;
      break; 
    }
  }
  
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
            color: Color(0xFFF1F0F0),
            child: Center(
              child: _showpage,         
            ),  
          ),
        
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 73.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.favorite, size: 30),
            Icon(Icons.gps_fixed, size: 30),
            Icon(Icons.view_list, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor:  Color(0xFFF1F0F0),
          animationCurve: Curves.ease,
          animationDuration: Duration(milliseconds: 250),
          onTap: (int tappedIndex) {
            setState(() {
              _showpage = _pageChooser(tappedIndex);
              
              // _pageV();
            });
          },
        ),
        );
  }
}