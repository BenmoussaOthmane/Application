import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:app/screen/detail_place.dart';
import 'package:app/screen/liste.dart';
import 'package:app/screen/place_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as prefix0;
import 'package:permission_handler/permission_handler.dart';

import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/timezone.dart';
// import 'package:search_map_place/search_map_place.dart';

const kGoogleApiKey = "API";

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController _controller;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  // Completer<GoogleMapController> _controllerr = Completer();
  static Position position, _currentPosition, cp;
  String searchAppr;
  // static const kGoogleApiKey = "API";
  double lnccn = 0;
  static LatLng _center = LatLng(35.933333, 0.083333);

  String _heading;

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_Style.json');
    controller.setMapStyle(value);
  }

  void _getCur() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16.0,
    )));
    double lat = position.latitude;
    double long = position.longitude;
    print('Lat :' + lat.toString());
    print('Long :' + long.toString());
  }

  void getLocationResult(String input) async {
    if (input.isEmpty) {
      setState(() {
        print(_heading);
      });
      return;
    }
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String request = '$baseUrl?input=$input&Key=$kGoogleApiKey&type=$type';
    Response response = await Dio().get(request);
    print(response);

    setState(() {
      print('result');
    });
  }

  Future<void> _handelPress() async {
    try {
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.overlay,
          language: 'dz',
          components: [new Component(Component.country, "dz")],
          radius: _center == null ? null : 10000);
      showDetailPlace(p.placeId);
    } catch (e) {}
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
  // Future<Null> displayPrediction(Prediction p) async {
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyDTDnQqw-YEmhF48sqjJz1eSfXV8jI0zDw');
  //   if (p != null) {
  //     PlacesDetailsResponse detail =
  //     await _places.getDetailsByPlaceId(p.placeId);

  //     var placeId = p.placeId;
  //     double lat = detail.result.geometry.location.lat;
  //     double lng = detail.result.geometry.location.lng;

  //     var address = await Geocoder.local.findAddressesFromQuery(p.description);
  //     print(lat);
  //     print(lng);
  //   }
  // }
  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetaiPlace(placeId)),
      );
    }
  }

  // final Set<prefix0.Polyline> polyline = {};
  // List<LatLng> latlngSegment1 = List();
  // List<LatLng> latlngSegment2 = List();
  // static LatLng _lat1 = LatLng(35.920721, 0.093118);
  // static LatLng _lat2 = LatLng(35.933333, 0.083333);
  // static LatLng _lat3 = LatLng(12.970387, 77.693621);
  // static LatLng _lat4 = LatLng(12.858433, 77.575691);
  // static LatLng _lat5 = LatLng(12.948029, 77.472936);
  // static LatLng _lat6 = LatLng(13.069280, 77.455844);

  // GoogleMapPolyline googleMapPolyline =
  //     new GoogleMapPolyline(apiKey: 'AIzaSyDTDnQqw-YEmhF48sqjJz1eSfXV8jI0zDw');
  // getSomePoint() async {
  //   routCode = await googleMapPolyline.getCoordinatesWithLocation(
  //       origin: LatLng(35.933333, 0.083333),
  //       destination: LatLng(35.920721, 0.093118),
  //       mode: RouteMode.driving);
  // }

  @override
  void initState() {
    super.initState();
    _heading = "loiding";
    // _getCur();
    // getSomePoint();
    // latlngSegment1.add(_lat1);
    // latlngSegment1.add(_lat2);
    // latlngSegment1.add(_lat3);
    // latlngSegment1.add(_lat4);

    // latlngSegment2.add(_lat4);
    // latlngSegment2.add(_lat5);
    // latlngSegment2.add(_lat6);
    // latlngSegment2.add(_lat1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            compassEnabled: true,
            // polylines: polyline,
            markers: _creatMarker(),
            initialCameraPosition: CameraPosition(
              bearing: 192.8334901395799,
              target: _center,
              zoom: 16,
            ),
          ),

          Positioned(
            top: 50,
            right: 15,
            left: 15,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Entre Adress ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: shearchandNavigation,
                      iconSize: 30,
                    )),
                onChanged: (text) {
                  setState(() {
                    searchAppr = text;
                  });
                },
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 15,
            left: 15,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Entre Adress ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _handelPress,
                      iconSize: 30,
                    )),
                // onChanged: (text) {
                //   getLocationResult(text);
                // },
              ),
            ),
          ),
          // Positioned(
          //   top: 150,
          //   right: 15,
          //   left: 15,
          //   child: Container(
          //     height: 50,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //       color: Colors.white
          //     ),
          //     child: RaisedButton(
          //    onPressed: () async {
          //       // show input autocomplete with selected mode
          //       // then get the Prediction selected
          //       Prediction p = await PlacesAutocomplete.show(
          //          context: context,
          //               apiKey: kGoogleApiKey,
          //               mode: Mode.fullscreen, // Mode.fullscreen
          //               language: "fr",
          //               components: [new Component(Component.country, "dz")]
          //         );
          // displayPrediction(p);
          //   },
          //  child: Text('Find address'),

          // )
          //   ),
          // ),
        ],
      ),
    );
  }

  // Future<void> _handlePressButton() async {

  //   Prediction p = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: kGoogleApiKey,
  //     // onError: onError,
  //     mode: Mode.fullscreen,
  //     language: "fr",
  //     components: [Component(Component.country, "fr")],
  //   );

  //   displayPrediction(p, homeScaffoldKey.currentState);
  // }
//  Future<Null> displayPrediction(Prediction p) async {
//     if (p != null) {
//       PlacesDetailsResponse detail =
//       await _places.getDetailsByPlaceId(p.placeId);

//       var placeId = p.placeId;
//       double lat = detail.result.geometry.location.lat;
//       double lng = detail.result.geometry.location.lng;

//       var address = await Geocoder.local.findAddressesFromQuery(p.description);

//       print(lat);
//       print(lng);
//       print(address);
//     }
//   }

  shearchandNavigation() {
    if (searchAppr.isEmpty) {
      print('raha khawya');
    } else {
      Geolocator().placemarkFromAddress(searchAppr).then((result) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 16.0,
        )));
      });
    }
  }

  void _onMapCreated(controller) {
   
      _controller = controller;
      _setStyle(controller);

      // polyline.add(prefix0.Polyline(
      //   polylineId: PolylineId('line1'),
      //   visible: true,
      //   //latlng is List<LatLng>
      //   points: latlngSegment2,
      //   width: 4,
      //   color: Colors.white,
      // ));
   
  }

  Set<Marker> _creatMarker() {
    var tmp = Set<Marker>();
    tmp.add(Marker(markerId: MarkerId("formPoint"), position: _center));
    return tmp;
  }
}
