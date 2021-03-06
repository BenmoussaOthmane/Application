import 'package:animate_do/animate_do.dart';
import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/screen/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  static final String id = 'signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;
  String error = '';
  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_name.isEmpty || _email.isEmpty || _password.isEmpty) {
        if (_name.isEmpty) {
          error = 'fill in all the information';
          _showDialog();
        } else {
          if (!_email.contains('@')) {
            error = 'email : invalid format';
            _showDialog();
          } else {
            if (_password.length < 6) {
              error = 'password : number of characters <6';
              _showDialog();
            }
          }
        }
      } else {
        // print('kolach rah riglo');
        Authservice.siginUpUser(context, _name, _email, _password);
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
                // 0.3,
                0.4,
                1.0
              ],
              colors: [
                Color(0xFFc5426e),
                // Color(0xFF672b73),
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
                // Form()
                SizedBox(height: MediaQuery.of(context).size.height / 150),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          0.2,
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          )),
                      SizedBox(height: MediaQuery.of(context).size.height / 70),
                      FadeAnimation(
                          0.3,
                          Text(
                            'Welcome To  Application',
                            style: TextStyle(
                              color: Color.fromRGBO(216, 216, 216, 3),
                              fontFamily: 'Arial',
                              // fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 150),
                      FadeAnimation(
                          0.4,
                          Text(
                            'Create Account',
                            style: TextStyle(
                              color: Color.fromRGBO(216, 216, 216, 3),
                              fontFamily: 'Georgia',
                              // fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 200),
                Expanded(
                  child: Container(
                    // height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                BounceInUp(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.15,
                                    height: 60,
                                    margin:
                                        EdgeInsets.only(left: 30, right: 30),
                                    // padding: EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 4),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                                          horizontal: 30.0, vertical: 10.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: 'Name',
                                            border: InputBorder.none,
                                            icon: Icon(Icons.person)),
                                        // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                                        onSaved: (input) => _name = input,
                                      ),
                                    ),
                                  ),
                                ),
                                BounceInUp(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.15,
                                    height: 60,
                                    // padding: EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 4),
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                                          horizontal: 30.0, vertical: 10.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: 'Email',
                                            border: InputBorder.none,
                                            icon: Icon(Icons.email)),
                                        // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                                        onSaved: (input) => _email = input,
                                      ),
                                    ),
                                  ),
                                ),
                                BounceInUp(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.15,
                                    height: 60,
                                    margin: EdgeInsets.only(top: 20),
                                    // padding: EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 4),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                                          horizontal: 30.0, vertical: 10.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: 'PassWord',
                                            border: InputBorder.none,
                                            icon: Icon(Icons.lock)),
                                        obscureText: true,
                                        // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                                        onSaved: (input) => _password = input,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 35,
                                ),
                                BounceInUp(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        13.5,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
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
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(2, 78, 95, .2),
                                              blurRadius: 10,
                                              offset: Offset(4.0, 4.0))
                                        ]),
                                    child: FlatButton(
                                      onPressed: _submit,
                                      child: Text(
                                        'Registred',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60,
                                ),
                                FadeAnimation(
                                    1.1,
                                    Container(
                                      child: Text(
                                        '_______________________ OR ______________________',
                                      ),
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40,
                                ),
                                BounceInUp(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        13.5,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFF672b73)),
                                      // color: Color.fromRGBO(6, 52, 95, 2),
                                      borderRadius: BorderRadius.circular(50),

                                      // boxShadow: [BoxShadow(
                                      //   color: Color.fromRGBO(2, 78, 95, .2),
                                      //   blurRadius: 25,
                                      //   offset: Offset(0,35)
                                      // )]
                                    ),
                                    child: FlatButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, Login.id),
                                      child: Text(
                                        'Log In',
                                        style: TextStyle(
                                            color: Color(0xFF672b73),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Arial'),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          )
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
