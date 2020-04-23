import 'package:animate_do/animate_do.dart';
import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Animation/FadeAnimationmataht.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = 'API';

class Detailpageliste extends StatefulWidget {
  final DocumentSnapshot list;
  Detailpageliste({this.list});

  static final String id = 'detailpageliste';
  @override
  _DetailpagelisteState createState() => _DetailpagelisteState();
}

class _DetailpagelisteState extends State<Detailpageliste>
    with SingleTickerProviderStateMixin {
  Color backBtn = Colors.grey[300];
  double withAnimatedBtn = 170;
  Icon _icon = Icon(
    FontAwesomeIcons.plus,
    color: Color(0xFFc5426e),
  );
  String ref;
  List<IconData> _listicon = [];
  Animation animation;
  AnimationController animationController;
  void animated() {
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  String mahlolmabla3 = ' ';
  Icon _close = Icon(
    FontAwesomeIcons.storeSlash,
    color: Color(0xFFc5426e),
  );
  GoogleMapController _controller;
  var geolocator = Geolocator();
  double latD, longD;
  double distance = 0.0;
  String timeE = 'OO';
  int he = 0;
  int min = 0;

  // // int d = DateTime.now().weekday;

  void _getCur() async {
    double latt = double.parse(widget.list.data['latitud']);
    double lang = double.parse(widget.list.data['longutude']);
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latD = position.latitude;
    longD = position.longitude;
    print('Lat :' + latD.toString());
    print('Long :' + longD.toString());
    distance = await geolocator.distanceBetween(latD, longD, latt, lang);
    distance = distance / 100;
    print(distance);

    double vM = distance / 4;
    vM = vM * 60;
    timeE = vM.round().toString();
    // print(timeE);
    if (vM > 60) {
      he = (vM / 60).toInt();
      print(he.toString() + 'H');
      vM = vM % 60;
      min = (vM % 60).toInt();
      print(min.toString() + 'min');
    }

    double vV = distance / 20;
    print(vV);
    double vL = distance / 80;
    print(vL);
  }

  @override
  void initState() {
    // uidPlaces();
    // fetchPlaceDetail();

    // getPlace();
    super.initState();
    // _getCur();

    Future.delayed(Duration(seconds: 1), () {
      _getCur();
    });
  }

  Container buildPhotoURL(String photoReference) {
    double start = double.parse(widget.list.data['rating']);
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

    String open = widget.list.data['open'];
    if (open == 'Close') {
      mahlolmabla3 = 'Close';
      _close = Icon(
        FontAwesomeIcons.storeSlash,
        color: Color(0xFFc5426e),
      );
    } else {
      mahlolmabla3 = 'Opening Now';
      _close = Icon(
        FontAwesomeIcons.storeAlt,
        color: Color(0xFFc5426e),
      );
    }
    final urll =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=${photoReference}&key=${kGoogleApiKey}";
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          image: DecorationImage(image: NetworkImage(urll), fit: BoxFit.cover)),
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 12, bottom: 55),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.bottomRight,
              // end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.5),
                Colors.black.withOpacity(.1)
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            FadeAnimation(
                1.6,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.list.data['name'],
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontFamily: 'GothamRoundedMedium_21022',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 15),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    Text(
                      widget.list.data['type'],
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 3,
                        fontFamily: 'GothamRoundedLight 21020',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.arrowsAltH,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 50,
                        ),
                        Text(
                          distance.toStringAsFixed(2),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GothamRoundedLight 21020',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Km',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GothamRoundedLight 21020',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _getIcon(0),
                            _getIcon(1),
                            _getIcon(2),
                            _getIcon(3),
                            _getIcon(4),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.list.data['rating'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width/2.6,),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.clock,
                              size: 15,
                              color: Colors.white,
                            ),
                            Text(
                              ' ' +
                                  he.toString() +
                                  'h' +
                                  ' ' +
                                  min.toString() +
                                  'min',
                              // '12h 30min',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'GothamRoundedLight 21020',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 30),
                            )
                          ],
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 60,
                        // ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
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
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: double.infinity,
              color: Colors.black,
              child: buildPhotoURL(widget.list.data['photo']),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -40),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: <Widget>[
                      BounceInLeft(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 7.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
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
                              child: Icon(
                                FontAwesomeIcons.globe,
                                color: Color(0xFFc5426e),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.list.data['phone'],
                                  style: TextStyle(
                                      letterSpacing: 3,
                                      color: Color(0xFF212121),
                                      fontFamily: 'GothamRoundedLight 21020',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 250,
                                ),
                                Text(
                                  widget.list.data['address'],
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontFamily: 'GothamRoundedMedium_21022',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      BounceInRight(
                        child: Row(
                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 7.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
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
                                child: _close),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  mahlolmabla3,
                                  style: TextStyle(
                                    color: Color(0xff212121),
                                    fontFamily: 'GothamRoundedMedium_21022',
                                    fontSize: 19,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Opning Time : ',
                                      style: TextStyle(
                                        color: Color(0xff212121),
                                        fontFamily: 'GothamRoundedMedium_21022',
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'opning khasni ndirha f la BDD',
                                      style: TextStyle(
                                        color: Color(0xff212121),
                                        fontFamily: 'GothamRoundedMedium_21022',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      FadeInUp(
                        child: Center(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: MediaQuery.of(context).size.height / 13,
                            width: withAnimatedBtn,
                            decoration: BoxDecoration(
                              color: backBtn,
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
                            child: IconButton(
                                icon: _icon,
                                iconSize: 30,
                                onPressed: () {
                                  setState(() {
                                    withAnimatedBtn = 80;
                                    backBtn = Color(0xFF672b73);
                                    _icon = Icon(
                                      FontAwesomeIcons.check,
                                      color: Colors.white,
                                    );
                                  });
                                  _getCur();
                                  print('object');
                                  // getPostplace();
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
