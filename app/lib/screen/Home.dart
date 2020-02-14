import 'package:app/Service/auth_service.dart';
import 'package:app/screen/favorit.dart';
import 'package:app/screen/feed.dart';
import 'package:app/screen/liste.dart';
import 'package:app/screen/location.dart';
import 'package:app/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  final String userId;
  Home({this.userId});
  static final id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  final Feed _feed = Feed();
  final Favorit _favorit = Favorit();
  final Location _location = Location();
  final Liste _liste = Liste();
  final Profile _profile = Profile();

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
//  _pageV(){
//   return PageView(
//     children: <Widget>[
//       Profile(userId: widget.userId,)
//     ],
//   );
// }


  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          animationDuration: Duration(milliseconds: 500),
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








// rules_version = '2';
// service cloud.firestore {
//   match /databases/{database}/documents {

//     // This rule allows anyone on the internet to view, edit, and delete
//     // all data in your Firestore database. It is useful for getting
//     // started, but it is configured to expire after 30 days because it
//     // leaves your app open to attackers. At that time, all client
//     // requests to your Firestore database will be denied.
//     //
//     // Make sure to write security rules for your app before that time, or else
//     // your app will lose access to your Firestore database
//     match /{document=**} {
//       allow read, write: if request.time < timestamp.date(2020, 2, 5);
//     }
//   }
// }