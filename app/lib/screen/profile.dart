import 'dart:io';
import 'dart:math';

import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screen/Home.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/signup.dart';
import 'package:app/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String userId;
  Profile({this.userId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _showDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Log Out',
                  style: TextStyle(
                      color: Colors.red,
                      letterSpacing: 3,
                      fontFamily: 'calibri',
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'Are you sure log out',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'calibri',
                    fontSize: 15
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton(
                  onPressed: ()=>Authservice.logout(context),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Text(
                  'Setting',
                  style: TextStyle(
                      letterSpacing: 3,
                      color: Color(0xff10375c),
                      fontFamily: 'calibri',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height/80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5.0, -5.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'calibri',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 150,
                              ),
                              Text(
                                Authservice.nameee,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'calibri',
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => Navigator.pushReplacementNamed(context,UPdateusers.id),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        Divider(
                          height: 10,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        SwitchListTile(
                          activeColor: Color(0xff10375c),
                          value: false,
                          onChanged: (val) {},
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Dark Theme',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'calibri',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 150,
                              ),
                              Text(
                                'Activity the dark theme throughout the application',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'calibri',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        Divider(
                          height: 10,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        SwitchListTile(
                          activeColor: Color(0xff10375c),
                          value: true,
                          onChanged: (val) {},
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Notification',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'calibri',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 150,
                              ),
                              Text(
                                'Disable notifications',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'calibri',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        Divider(
                          height: 10,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        FlatButton(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Help',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'calibri',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 150,
                              ),
                              Text(
                                'Benmoussa othmane',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'calibri',
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => print('Help'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        Divider(
                          height: 10,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        FlatButton(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'calibri',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 150,
                              ),
                              Text(
                                'are you sure logout',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'calibri',
                                ),
                              ),
                            ],
                          ),
                          onPressed: _showDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
