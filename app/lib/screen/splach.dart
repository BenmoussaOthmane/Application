import 'package:app/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Splach extends StatefulWidget {
  final String userId;
  
  Splach({this.userId});
  static final String id = 'splach';
  @override
  _SplachState createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      (){
        Navigator.push(context,PageTransition(type: PageTransitionType.fade,duration: Duration(milliseconds: 300),child: Home()));
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
         child: Container(
           height: MediaQuery.of(context).size.height/5,
           width: MediaQuery.of(context).size.width/3,
           decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/images/logo wahdo x2.png'),
             )
           ),
         ),
        ),
      ),
    );
  }
}