import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Container buildPhotoURL(String photoReference) {
    // AsyncSnapshot snapshot;
    // var index;
    // DocumentSnapshot documentSnapshot =
    //                       snapshot.data.documents[index];
    final urll =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(begin: Alignment.bottomRight,
              // end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.1)
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'dmfkdsmk',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
        backgroundColor: Colors.grey[300],
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
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                        color: Color(0xff10375c),
                        fontFamily: 'BalooTamma2 Bold',
                        fontSize: MediaQuery.of(context).size.width / 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  // color: Colors.black,
                  height: MediaQuery.of(context).size.height / 1.3,
                  // width: MediaQuery.of(context).size.width/1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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

                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 18, right: 18, top: 0, bottom: 25),
                          height: MediaQuery.of(context).size.height / 1.4,
                          width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 5)
                              ]),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: buildPhotoURL(documentSnapshot['photo']),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
