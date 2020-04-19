import 'dart:math';

import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/screen/Home.dart';
import 'package:app/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static final String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name;
  String error = '';

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_email.isEmpty || _password.isEmpty) {
        if (!_email.contains('@')) {
          error = 'email : invalid format';
          _showDialog();
        } else {
          if (_password.length < 6) {
            error = 'password : number of characters <6';
            _showDialog();
          }
        }
      } else {
        // print('kolach rah riglo');
        Authservice.login(context, _email, _password);
        ;
      }
    }
  }

  void _showDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              error,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('Back'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.1,
                0.3,
                0.5,
                1.0
              ],
              colors: [
                Color(0xFFc5426e),
                Color(0xFF672b73),
                Color(0xFF672b73),
                Color(0xFF672b73),
              ]),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          0.5,
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          )),
                      SizedBox(
                        height: 5.0,
                      ),
                      FadeAnimation(
                          0.7,
                          Text(
                            'Welcome To  Application',
                            style: TextStyle(
                              color: Color.fromRGBO(216, 216, 216, 3),
                              fontFamily: 'Arial',
                              // fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(160.0)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FadeAnimation(
                                    0.6,
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.15,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      // padding: EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 4),
                                      margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.white,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 5.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Email',
                                              border: InputBorder.none,
                                              icon: Icon(Icons.email)),
                                          // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                                          onSaved: (input) => _email = input,
                                        ),
                                      ),
                                    )),
                                FadeAnimation(
                                    0.7,
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.15,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              14,
                                      margin: EdgeInsets.only(top: 20),
                                      // padding: EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.white,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 5.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'PassWord',
                                              border: InputBorder.none,
                                              icon: Icon(Icons.lock)),
                                          // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                                          onSaved: (input) => _password = input,
                                          obscureText: true,
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                FadeAnimation(
                                    0.8,
                                    Container(
                                      height: 58,
                                      width: MediaQuery.of(context).size.width /
                                          1.55,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              stops: [
                                                0.1,
                                                // 0.3,
                                                // 0.6,
                                                1.0
                                              ],
                                              colors: [
                                                Color(0xFFc5426e),
                                                Color(0xFF672b73),
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    2, 78, 95, .2),
                                                blurRadius: 10,
                                                offset: Offset(0, 15))
                                          ]),
                                      child: FlatButton(
                                        onPressed: _submit,
                                        child: Text(
                                          'Log in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                FadeAnimation(
                                    1.1,
                                    Container(
                                        // color: Colors.black,
                                        // height: 10,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.15,
                                        child: Center(
                                          child: Text(
                                              '____________________ OR ____________________'),
                                        ))),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                ),
                                FadeAnimation(
                                    1.2,
                                    Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width /
                                          1.55,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFF672b73),
                                        ),
                                        // color: Color.fromRGBO(6, 52, 95, 2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: FlatButton(
                                          padding: EdgeInsets.all(15),
                                          onPressed: () => Navigator.pushNamed(
                                              context, Signup.id),
                                          child: Text(
                                            'Creat New Account !',
                                            style: TextStyle(
                                                color: Color(0xFF672b73),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Arial'),
                                          ),
                                        ),
                                      ),
                                    )),
                                // SizedBox(height: 18,),
                                // FadeAnimation(0.9,Container(
                                //   child: Center(
                                //     child: FlatButton(
                                //       onPressed: ()=> Navigator.pushNamed(context,Signup.id),
                                //         child: Text(
                                //           'Creat New Account !',
                                //            style: TextStyle(
                                //              color: Colors.black87,
                                //              fontSize: 17,
                                //              fontFamily: 'Georgia'
                                //            ),
                                //         ),
                                //     ),
                                //   ),
                                // ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
