import 'dart:io';

import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/Service/databseupdate.dart';
import 'package:app/main.dart';
import 'package:app/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UPdateusers extends StatefulWidget {
  static final String id = 'updateusers';
  // final String userId;
  // UPdateusers({this.userId});

  @override
  _UPdateusersState createState() => _UPdateusersState();
}

class _UPdateusersState extends State<UPdateusers> {
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
    // print('objectA');
    // setState(() {
    //   print('update Profile');
    //   print(storageTaskSnapshot);
    // });
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
        print(
            'LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
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
        print(_currentAddress);
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

//  _submit(BuildContext context)async{
//    String _profielImageUrl ='';
//    if(_profileImage == null){
//      _profielImageUrl = Authservice.imagee;
//    }
//    _profielImageUrl = await uploadPick(context);
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: StreamBuilder(
        stream:
            Firestore.instance.collection('users').document(uiiid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          User user = User.fromDocument(snapshot.data);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Column(
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff10375c),
                        ),
                        onPressed: () => Navigator.pop(context)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    Text(
                      'Profiel',
                      style: TextStyle(
                          color: Color(0xff10375c),
                          letterSpacing: 3,
                          fontFamily: 'calibri',
                          fontSize: MediaQuery.of(context).size.width / 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 35,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: FadeAnimation(
                      1,
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
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
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor: Colors.grey[500],
                              backgroundImage: displayProfiel(),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Edit Picture',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'calibri',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                                  child: IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.camera,
                                        color: Color(0xff3b6978),
                                        size: 25,
                                      ),
                                      onPressed: _handelImageNetwork)),
                            ],
                          )
                        ],
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: <Widget>[
                      FadeAnimation(
                          1.3,
                          Text('Account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontFamily: 'calibri',
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                FadeAnimation(
                    1.6,
                    Container(
                      height: MediaQuery.of(context).size.height / 2.2,
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
                            horizontal: 30, vertical: 48),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width:
                                      MediaQuery.of(context).size.width / 7.7,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3b6978).withOpacity(.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    color: Color(0xff3b6978),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'User Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'calibri',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              150,
                                    ),
                                    Text(
                                      user.name,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: 'calibri',
                                          fontSize: 15),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 38,
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 38,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width:
                                      MediaQuery.of(context).size.width / 7.7,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3b6978).withOpacity(.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Icon(
                                    FontAwesomeIcons.at,
                                    color: Color(0xff3b6978),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'calibri',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              150,
                                    ),
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: 'calibri',
                                          fontSize: 15),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 38,
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 38,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width:
                                      MediaQuery.of(context).size.width / 7.7,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3b6978).withOpacity(.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Color(0xff3b6978),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'calibri',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              150,
                                    ),
                                    if (_currentAddress != null)
                                      Text(
                                        _currentAddress,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontFamily: 'calibri',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                35),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),

      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Update Users',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 25,
      //       fontWeight: FontWeight.bold,
      //       letterSpacing: 2,
      //     ),
      //   ),
      //   iconTheme: IconThemeData(color: Colors.black),
      // ),
      // body: Container(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       CircleAvatar(
      //         radius: 50,
      //         backgroundImage: displayProfiel(),
      //       ),
      //       SizedBox(height: 20,),
      //       Container(
      //         height: 50,
      //         width: 150,
      //         child: FlatButton(
      //           onPressed: _handelImageNetwork,
      //           child:Text(
      //             'submite'
      //           )),
      //       ),
      //       // SizedBox(height: 10,),
      //       Container(
      //         height: 50,
      //         width: 150,
      //         child: FlatButton(
      //           onPressed: ()=>uploadPick(context),
      //           child:Text(
      //             'save'
      //           )),
      //       )
      //     ],
      //   )
      // )
    );
  }
}

// if (snapshot.hasError)
//         return new Text('Error: ${snapshot.error}');
//       switch (snapshot.connectionState) {
//         case ConnectionState.waiting: return new Text('Loading...');
//         default:

//           return new ListView(
//             children: snapshot.data.documents.map((DocumentSnapshot document) {
//               return new ListTile(
//                 title: new Text(document['email']),
//                 subtitle: new Text(document['name']),
//               );
//             }).toList(),
//             );

//////////////////////////////////////////////////

//  hnaya sat ghir ki njib email//////////
//  body: new FutureBuilder<FirebaseUser>(
//       future:  _firebaseAuth.currentUser(),
//       // hadi ta3 la liste li ghadi nakhdam biha kach nhar tabda mana wtakmal malhih
//       builder :(BuildContext context, AsyncSnapshot <FirebaseUser> snapshot){

//           if(snapshot.connectionState == ConnectionState.done){
//           String usersEmail = snapshot.data.email;
//           String usersName = snapshot.data.toString();
//           print(usersEmail);
//           print(usersName);
//           // User user = User.formDoc(data['name']);
//           // print(snapshot.data[]);
//           // return Text(
//           //   userID
//           // );

//         }
