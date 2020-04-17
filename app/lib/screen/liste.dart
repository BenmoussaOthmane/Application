import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kGoogleApiKey = "API";

class Liste extends StatefulWidget {
  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
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
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          image: DecorationImage(image: NetworkImage(urll), fit: BoxFit.cover)),
    );
    // return Image.network(
    //   urll,
    //   fit: BoxFit.cover,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: const EdgeInsets.only(top: 45, left: 20),
                child: Text(
                  'My Trips',
                  style: TextStyle(
                      color: Color(0xff10375c),
                      fontFamily: 'BalooTamma2 Bold',
                      fontSize: MediaQuery.of(context).size.width / 12,
                      fontWeight: FontWeight.bold),
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
                        color: Colors.amber[700],
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.only(
                          left: 18, right: 18, top: 0, bottom: 25),
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 1,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                            ),
                            child: buildPhotoURL(documentSnapshot['photo']),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                documentSnapshot['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'BalooTamma2 Regular',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              // SizedBox(height: MediaQuery.of(context).size.height/100,),
                              Text(
                                documentSnapshot['type'],
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'BalooTamma2 Regular',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Color(0xff10375c),
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
                                        fontFamily: 'BalooTamma2 Regular',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.storeAlt,
                                    size: 12,
                                    color: Color(0xff3b6978),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 30,
                                  ),
                                  Text(
                                    documentSnapshot['open'],
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'BalooTamma2 Regular',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  _getIcon(0),
                                  _getIcon(1),
                                  _getIcon(2),
                                  _getIcon(3),
                                  _getIcon(4),
                                ],
                              )
                            ],
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
