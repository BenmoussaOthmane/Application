import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "API";

class Favorit extends StatefulWidget {
  @override
  _FavoritState createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  List<IconData> _listicon = [];

  @override
  void initState() {
    super.initState();
  }

  Container buildPhotoURL(String photoReference) {
    final urll =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          image: DecorationImage(image: NetworkImage(urll), fit: BoxFit.cover)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10,right: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300].withOpacity(.8),
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Color(0xFF672b73),
                  size: 18,
                ),
              ),
            ],
          ),
    );
    // return Image.network(
    //   urll,
    //   fit: BoxFit.cover,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f7fa),
        // backgroundColor: Colors.grey[300],
        // appBar: AppBar(
        //   backgroundColor: Colors.grey[300],
        // ),
        body: StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(uiiid)
          .collection('places')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                // color: Colors.black,
                padding: const EdgeInsets.only(top: 40, left: 20),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                      color: Color(0xFF672b73),
                      fontFamily: 'GothamRoundedBook 21018',
                      fontSize: MediaQuery.of(context).size.width / 15,
                      fontWeight: FontWeight.bold
                      ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                // color: Colors.black,
                height: MediaQuery.of(context).size.height / 1.4,
                child: ListView.builder(
                  reverse: false,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];
                    // print(documentSnapshot['rating']);
                    double start = double.parse(documentSnapshot['rating']);
                    Widget _getIcon(int index) {
                      if (start == 1) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start > 1 && start < 2) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.starHalfAlt,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start == 2) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start > 2 && start < 3) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.starHalfAlt,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start == 3) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.star,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start > 3 && start < 4) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.starHalfAlt,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start == 4) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.star,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start > 4 && start < 5) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.starHalfAlt,
                        ];
                        // return Icon(_listicon[index]);
                      }
                      if (start == 5) {
                        _listicon = [
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                          FontAwesomeIcons.solidStar,
                        ];
                        // return Icon(_listicon[index]);
                      }

                      return Icon(
                        _listicon[index],
                        size: 16,
                        color: Color(0xFFc5426e),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.only(
                          left: 18, right: 18, top: 0, bottom: 25),
                      height: MediaQuery.of(context).size.height / 3.7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400],
                                offset: Offset(5.0, 5.0),
                                blurRadius: 50.0,
                                spreadRadius: 10),
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 50.0,
                                spreadRadius: 10),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 1,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: buildPhotoURL(documentSnapshot['photo']),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 18,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5,left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  documentSnapshot['name'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'GothamRoundedBook 21018',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(height: MediaQuery.of(context).size.height/30,),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      color: Color(0xFFc5426e),
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 50,
                                    ),
                                    Text(
                                      documentSnapshot['address'],
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontFamily: 'GothamRoundedBook 21018',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 100,
                                ),
                                Row(
                                  children: <Widget>[
                                    _getIcon(0),
                                    _getIcon(1),
                                    _getIcon(2),
                                    _getIcon(3),
                                    _getIcon(4),
                                    SizedBox(width: 13,),
                                    Text(
                                      documentSnapshot['rating'],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
