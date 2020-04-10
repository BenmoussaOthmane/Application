import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "API";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class DetaiPlace extends StatefulWidget {
  // static final String id = 'detailplace';
  String placeId;
  DetaiPlace(String placeId) {
    this.placeId = placeId;
  }

  @override
  _DetaiPlaceState createState() => _DetaiPlaceState();
}

class _DetaiPlaceState extends State<DetaiPlace> {
  GoogleMapController mapController;
  PlacesDetailsResponse place;
  bool isLoading = false;
  String errorLoading;
  double withAnimatedBtn = 170;
  Icon _icon = Icon(FontAwesomeIcons.plus);

  // Animation animation;
  // AnimationController animationController;
  // bool reverSinimation = false;

  // void animated() {
  //   animationController =
  //       new AnimationController(vsync: this, duration: Duration(seconds: 1));
  //   animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  // }

  void fetchPlaceDetail() async {
    setState(() {
      this.isLoading = true;
      this.errorLoading = null;
    });

    PlacesDetailsResponse place =
        await _places.getDetailsByPlaceId(widget.placeId);

    if (mounted) {
      setState(() {
        this.isLoading = false;
        if (place.status == "OK") {
          this.place = place;
        } else {
          this.errorLoading = place.errorMessage;
        }
      });
    }
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
  }

  @override
  void initState() {
    fetchPlaceDetail();
    // animated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String namePlace;
    String formAddress;
    String type;
    String phoneNumber;
    var mahlolwalaMbala3;
    String mahlolMbalaa;
    String siteWeb;
    double rating;
    int count;
    bool notNul = false;
    Widget listePPP;

    if (isLoading) {
      namePlace = 'Loawding';
    } else if (errorLoading != null) {
      namePlace = '';
    } else {
      final placeDetail = place.result;
      final location = place.result.geometry.location;
      final lat = location.lat;
      final lng = location.lng;

      namePlace = placeDetail.name;
      if (placeDetail.formattedAddress != null) {
        formAddress = placeDetail.formattedAddress;
      }
      if (placeDetail.types?.first != null) {
        type = placeDetail.types.first.toUpperCase();
      }
      if (placeDetail.formattedPhoneNumber != null) {
        phoneNumber = placeDetail.formattedPhoneNumber;
      }
      if (placeDetail.openingHours != null) {
        final openFer = placeDetail.openingHours;
        mahlolwalaMbala3 = '';
        if (openFer.openNow) {
          mahlolMbalaa = 'Opening Now';
          // print('Opening Now');
        } else {
          mahlolMbalaa = 'Close';
          // print('Close');
        }
      }
      if (placeDetail.website != null) {
        siteWeb = placeDetail.website;
      }
      if (placeDetail.rating != null) {
        rating = placeDetail.rating;
      }
      // List <Widget> photoliste = [];

      if (placeDetail.photos != null) {
        
        final photos = placeDetail.photos;
        // count = photos.length;

        listePPP = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(right: 1),
              child: Image.network(
                buildPhotoURL(photos[index].photoReference),
              ),
            );
          },
        );
      }
    }


    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child:listePPP,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 7.6,
                        decoration: BoxDecoration(
                            color: Color(0xff3b6978).withOpacity(.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                            'Destination',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'calibri',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 150,
                          ),
                          Text(
                            formAddress,
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
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 7.6,
                        decoration: BoxDecoration(
                            color: Color(0xff3b6978).withOpacity(.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          FontAwesomeIcons.phoneAlt,
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
                            'Phone',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'calibri',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 150,
                          ),
                          Text(
                            phoneNumber,
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
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 7.6,
                        decoration: BoxDecoration(
                            color: Color(0xff3b6978).withOpacity(.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          FontAwesomeIcons.storeAlt,
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
                            'Open',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'calibri',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 150,
                          ),
                          Text(
                            mahlolMbalaa,
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
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 7.6,
                        decoration: BoxDecoration(
                            color: Color(0xff3b6978).withOpacity(.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          FontAwesomeIcons.globe,
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
                            'Website',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'calibri',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 150,
                          ),
                          Text(
                            siteWeb,
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
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: MediaQuery.of(context).size.height / 13,
                      width: withAnimatedBtn,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(70)),
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
                          icon: _icon,
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              withAnimatedBtn = 80;
                              _icon = Icon(
                                FontAwesomeIcons.check,
                                color: Colors.green,
                              );
                            });
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
