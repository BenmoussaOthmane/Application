import 'package:flutter/material.dart';

class UPdateusers extends StatefulWidget {
  static final String id = 'updateusers';
  @override
  _UPdateusersState createState() => _UPdateusersState();
}

class _UPdateusersState extends State<UPdateusers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme:IconThemeData(
          color: Colors.black,
          size: 25
        ),
        title: Text(
          'Update',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 2
          ),
        ),
      ),
      body: Container(
      ),
    );
  }
}