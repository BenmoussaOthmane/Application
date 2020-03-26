import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:app/screen/liste.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_webservice/places.dart';
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
  // Completer<GoogleMapController> _controllerr = Completer();
  static Position position ,_currentPosition,cp;
  String searchAppr;
  static const kGoogleApiKey = "AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y";
  static double ln =Liste.cp.latitude;
  static double lnn = Liste.cp.longitude;
  double lnccn = 0;
  static LatLng _center = LatLng(0,0);
  final Map<String, Marker> _markers = {};
  Completer<GoogleMapController> _mapController = Completer();

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
  


   @override
   void initState(){
     super.initState();
     _getCur();
   }

  // final CameraPosition _initialCamera = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: _center,
  //   zoom: 16,
  // );

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
                  onChanged: (val){
                    setState(() {
                      searchAppr = val;
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
                // child: SearchMapPlaceWidget(
                //   apiKey: "AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y",
                //   // The language of the autocompletion
                //   language: 'fr',
                //   // The position used to give better recomendations. In this case we are using the user position
                //   location: _initialCamera.target,
                //   radius: 30,
                //   onSelected: (Place place) async {
                //       print(place.description);
                //       final geolocation = await place.geolocation;

                //       // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                //       final GoogleMapController controller = await _mapController.future;
                //       controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                //       controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                //   },

                // ),
                // child: TextField(
                //   onTap:()async{
                //     Prediction p = await PlacesAutocomplete.show(
                //           context: context,
                //           apiKey: "AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y",
                //           mode: Mode.overlay, // Mode.fullscreen
                //           language: "fr",
                //           components: [new Component(Component.country, "fr")]);

                //   },
                //   decoration: InputDecoration(
                //     hintText: 'Entre Adress ',
                //     border: InputBorder.none,
                //     contentPadding: EdgeInsets.only(left: 15.0,top:15.0 ),
                //     suffixIcon: IconButton(
                //       icon: Icon(Icons.search),
                //       onPressed: shearchandNavigation,
                //       iconSize: 30,
                //       )
                //   ),
                // ),

                child: RaisedButton(
                  onPressed: _handlePressButton,
                  child: Text("Search places"),
                ),
              ),
            ),
            // SizedBox(height: 10,width: 50,),
            // Padding(
            //   padding: const EdgeInsets.all(200.0),
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     color: Colors.amber,
            //     child: FlatButton(
            //       onPressed: _getCur,
            //       child:Text(
            //         'Posiont'
            //       )),
            //   ),
            // )
        ],
      ),  
    );
  }
//  void onError(PlacesAutocompleteResponse response) {
//     homeScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      // onError: onError,
      mode: Mode.fullscreen,
      language: "fr",
      components: [Component(Component.country, "fr")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }
  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}


  shearchandNavigation(){
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
