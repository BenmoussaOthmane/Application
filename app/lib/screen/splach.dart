import 'package:app/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Splach extends StatefulWidget {
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
          child: FlutterLogo(
            size: 200,
          ),
        ),
      ),
    );
  }
}