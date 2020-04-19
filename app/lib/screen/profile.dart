import 'dart:io';
import 'dart:math';

import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/main.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  final String userId;
  Profile({this.userId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  File _profileImage;

  _handelImageNetwork() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  Future uploadPick(BuildContext context) async {
    String _profielImageUrl = '';
    print('object');
    String filename = basename(_profileImage.path);
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask storageUploadTask =
        storageReference.putFile(_profileImage);
    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    String downloadURl = await storageTaskSnapshot.ref.getDownloadURL();
    if (_profileImage == null) {
      _profielImageUrl = Authservice.imagee;
    }
    _profielImageUrl = downloadURl;

    print(_profielImageUrl);
    print('objectA');
    setState(() {
      print('update Profile');
      print(storageTaskSnapshot);
    });
  }

  displayProfiel() {
    if (_profileImage == null) {
      return AssetImage(
          'assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg');
    } else {
      return FileImage(_profileImage);
    }
  }

  _getCurrentLocation() {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
        // print(
        //     'LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        // print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getCurrentLocation();
      _getAddressFromLatLng();
    });
  }

  void _showDialog(context) {
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Are you sure log out',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'calibri', fontSize: 15),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton(
                  onPressed: () => Authservice.logout(context),
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
        backgroundColor: Color(0xFFf5f7fa),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(uiiid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/2cbb5e95b97aa2b496f6eaec84b9240d.gif'),
                  )),
                ),
              );
            }
            User user = User.fromDocument(snapshot.data);
            return Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(5.0, 5.0),
                                blurRadius: 20.0,
                                spreadRadius: 1.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 85,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: displayProfiel(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          Text(
                            user.name,
                            style: TextStyle(
                                color: Color(0xFF212121),
                                letterSpacing: 2,
                                fontFamily: 'GothamRoundedBook 21018',
                                fontSize:
                                    MediaQuery.of(context).size.width / 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(
                                color: Color(0xFF2e2e2e),
                                letterSpacing: 2,
                                fontFamily: 'GothamRoundedBook 21018',
                                fontSize:
                                    MediaQuery.of(context).size.width / 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 10,
                                width: MediaQuery.of(context).size.width / 4.8,
                                decoration: BoxDecoration(
                                    color: Color(0xFFf5f7fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 5,
                                          spreadRadius: 2.0)
                                    ]),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.cog,
                                    size: 35,
                                  ),
                                  color: Colors.grey[500],
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, UPdateusers.id),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 10,
                                width: MediaQuery.of(context).size.width / 4.8,
                                decoration: BoxDecoration(
                                    color: Color(0xFFf5f7fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 5,
                                          spreadRadius: 2.0)
                                    ]),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 35,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed: _handelImageNetwork,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 20,),
                          Container(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 4.5,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      0.1,
                                      // 0.3,
                                      0.6,
                                      1.0
                                    ],
                                    colors: [
                                      Color(0xFFc5426e),
                                      Color(0xFFc5426e),
                                      Color(0xFF672b73),
                                    ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(3.0, 3.0),
                                      blurRadius: 5,
                                      spreadRadius: 2.0)
                                ]),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.powerOff,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: ()=>_showDialog(context),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: FadeAnimation(
                    1.5,
                    Container(
                      // color: Colors.amber,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 7,
                                decoration: BoxDecoration(
                                    color: Color(0xFFf5f7fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 5,
                                          spreadRadius: 2.0)
                                    ]),
                                child: Icon(
                                  FontAwesomeIcons.at,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2,
                                        fontFamily: 'GothamRoundedBook 21018',
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  ),
                                  Text(
                                    user.email,
                                    style: TextStyle(
                                        color: Color(0xFF2e2e2e),
                                        letterSpacing: 2,
                                        fontFamily: 'GothamRoundedBook 21018',
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                30),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 7,
                                decoration: BoxDecoration(
                                    color: Color(0xFFf5f7fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 5,
                                          spreadRadius: 2.0)
                                    ]),
                                child: Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2,
                                        fontFamily: 'GothamRoundedBook 21018',
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  ),
                                  if (_currentAddress != null)
                                    Text(
                                      _currentAddress,
                                      style: TextStyle(
                                          color: Color(0xFF2e2e2e),
                                          letterSpacing: 2,
                                          fontFamily: 'GothamRoundedBook 21018',
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              32),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            );
          },
        ));
  }
}
