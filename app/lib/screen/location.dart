import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:app/screen/liste.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/timezone.dart';

import 'package:search_map_place/search_map_place.dart';


class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();

}

class _LocationState extends State<Location> {
  
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController _controller;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "YOUR_API_KEY");
  // Completer<GoogleMapController> _controllerr = Completer();
  static Position position ,_currentPosition,cp;
  String searchAppr;
  static const kGoogleApiKey = "AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y";
  static double ln =Liste.cp.latitude;
  static double lnn = Liste.cp.longitude;
  double lnccn = 0;
  static LatLng _center = LatLng(0,0);

  String _heading;


  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_Style.json');
    controller.setMapStyle(value);
  }
   
  void _getCur()async{
     final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _controller.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(
         target: LatLng(position.latitude,position.longitude),
         zoom: 16.0,
       )
     )
     );
   }
  void getLocationResult(String input)async{
    if(input.isEmpty){
      setState(() {
        print(_heading);
      });
      return ;
    }
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String request = '$baseUrl?input=$input&Key=$kGoogleApiKey&type=$type';
    Response response = await Dio().get(request);
    print(response);

    setState(() {
      print('result');
    });
  }


   @override
   void initState(){
     super.initState();
     _heading = "loiding";
     _getCur();
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
              markers: _creatMarker(),
              initialCameraPosition:CameraPosition(
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
                  color: Colors.white
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Entre Adress ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0,top:15.0 ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: shearchandNavigation,
                      iconSize: 30,
                      )
                  ),
                  onChanged: (text){
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
                  color: Colors.white
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Entre Adress ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0,top:15.0 ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: shearchandNavigation,
                      iconSize: 30,
                      )
                  ),
                  onChanged: (text){
                    getLocationResult(text);
                  },
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
            //       // displayPrediction(p);
            //   },
            //  child: Text('Find address'),

            // )
            //   ),
            // ),
            
        ],
      ),  
    );
  }
// Future<Null> displayPrediction(Prediction p) async {
//   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
//     if (p != null) {
//       PlacesDetailsResponse detail =
//       await _places.getDetailsByPlaceId(p.placeId);

//       var placeId = p.placeId;
//       double lat = detail.result.geometry.location.lat;
//       double lng = detail.result.geometry.location.lng;

//       var address = await Geocoder.local.findAddressesFromQuery(p.description);
//       print(lat);
//       print(lng);
//     }
//   }

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


  shearchandNavigation(){
    if(searchAppr.isEmpty){
      print('raha khawya');
    }else{
        Geolocator().placemarkFromAddress(searchAppr).then((result){
          _controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: 
                  LatLng(result[0].position.latitude, result[0].position.longitude),
                  zoom: 16.0,
             )
          ));
        });
    }
    

  }
  
  void _onMapCreated(controller){
    _controller=controller;
    _setStyle(controller);
  }
  Set<Marker> _creatMarker(){
    var tmp = Set<Marker>();
    tmp.add(
      Marker(
        markerId: MarkerId("formPoint"),
        position: _center
      )
    );
    return tmp;
  }
}