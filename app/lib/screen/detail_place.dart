// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

// const kGoogleApiKey = "AIzaSyDTDnQqw-YEmhF48sqjJz1eSfXV8jI0zDw";
// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// class DetaiPlace extends StatefulWidget {
//   String placeId;

//   DetaiPlace(String placeId) {
//     this.placeId = placeId;
//   }

//   @override
//   State<StatefulWidget> createState() {
//     return PlaceDetailState();
//   }
// }

// class PlaceDetailState extends State<DetaiPlace>
//     with SingleTickerProviderStateMixin {
//   GoogleMapController mapController;
//   PlacesDetailsResponse place;
//   bool isLoading = false;
//   String errorLoading;

//   double withAnimatedBtn = 170;
//   Icon _icon = Icon(FontAwesomeIcons.plus);
//   Color backBtn = Colors.grey[300];
//   Icon _close;
//   Icon _raiting;

//   Animation animation;
//   AnimationController animationController;
//   bool reverSinimation = false;

//   void animated() {
//     animationController =
//         new AnimationController(vsync: this, duration: Duration(seconds: 1));
//     animation = Tween<double>(begin: 0, end: 1).animate(animationController);
//   }

//   @override
//   void initState() {
//     fetchPlaceDetail();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget bodyChild;
//     String title;
//     if (isLoading) {
//       title = "Loading";
//       bodyChild = Center(
//         child: CircularProgressIndicator(
//           value: null,
//         ),
//       );
//     } else if (errorLoading != null) {
//       title = "";
//       bodyChild = Center(
//         child: Text(errorLoading),
//       );
//     } else {
//       final placeDetail = place.result;
//       final location = place.result.geometry.location;
//       final lat = location.lat;
//       final lng = location.lng;
//       final center = LatLng(lat, lng);

//       title = placeDetail.name;
//       bodyChild = Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           // Container(
//           //     child: SizedBox(
//           //   height: 200.0,
//           //   child: GoogleMap(
//           //     // onMapCreated: _onMapCreated,
//           //     initialCameraPosition: CameraPosition(
//           //     bearing: 192.8334901395799,
//           //     target: LatLng(0, 0),
//           //     zoom: 16,
//           //   ),
//           //   ),
//           // )),
//           Expanded(
//             child: buildPlaceDetailList(placeDetail),
//           )
//         ],
//       );
//     }

//     return Scaffold(
//         backgroundColor: Colors.grey[300],
//         appBar: AppBar(
//           backgroundColor: Colors.grey[300],
//           leading: IconButton(
//               icon:
//                   Icon(FontAwesomeIcons.chevronLeft, color: Color(0xff10375c)),
//               onPressed: () => Navigator.pop(context)),
//           title: Text(
//             title,
//             style: TextStyle(
//                 color: Color(0xff10375c),
//                 letterSpacing: 3,
//                 fontFamily: 'BalooTamma2 Bold',
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold),
//           ),
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(
//                   FontAwesomeIcons.heart,
//                   color: Color(0xff10375c),
//                 ),
//                 onPressed: null)
//           ],
//         ),
//         body: bodyChild);
//   }

//   void fetchPlaceDetail() async {
//     setState(() {
//       this.isLoading = true;
//       this.errorLoading = null;
//     });

//     PlacesDetailsResponse place =
//         await _places.getDetailsByPlaceId(widget.placeId);

//     if (mounted) {
//       setState(() {
//         this.isLoading = false;
//         if (place.status == "OK") {
//           this.place = place;
//         } else {
//           this.errorLoading = place.errorMessage;
//         }
//       });
//     }
//   }

//   // void _onMapCreated(GoogleMapController controller) {
//   //   mapController = controller;
//   //   final placeDetail = place.result;
//   //   final location = place.result.geometry.location;
//   //   final lat = location.lat;
//   //   final lng = location.lng;
//   //   final center = LatLng(lat, lng);
//   //   var markerOptions = MarkerOptions(
//   //       position: center,
//   //       infoWindowText: InfoWindowText(
//   //           "${placeDetail.name}", "${placeDetail.formattedAddress}"));
//   //   mapController.addMarker(markerOptions);
//   //   mapController.animateCamera(CameraUpdate.newCameraPosition(
//   //       CameraPosition(target: center, zoom: 15.0)));
//   // }

//   String buildPhotoURL(String photoReference) {
//     return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
//   }

//   ListView buildPlaceDetailList(PlaceDetails placeDetail) {
//     List<Widget> list = [];
//     if (placeDetail.photos != null && placeDetail.photos != null) {
//       final photos = placeDetail.photos;
//       if (placeDetail.rating ==1) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating >1 && placeDetail.rating <1.5 || placeDetail.rating >1.5 && placeDetail.rating <2) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.starHalfAlt,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating ==2) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating >2 && placeDetail.rating <2.5 || placeDetail.rating >2.5 && placeDetail.rating <3 ) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.starHalfAlt,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating ==3) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating >3 && placeDetail.rating <3.5 || placeDetail.rating >3.5 && placeDetail.rating <4 ) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.starHalfAlt,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating ==4 ) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.star,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating >4 && placeDetail.rating <4.5 || placeDetail.rating >4.5 && placeDetail.rating <5 ) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.starHalfAlt,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//       if (placeDetail.rating ==5 ) {
//         list.add(SizedBox(
//             height: 280.0,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: photos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 1.1,
//                       child: Container(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text(
//                               placeDetail.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 2,
//                                 fontFamily: 'BalooTamma2 Bold',
//                                 fontSize: MediaQuery.of(context).size.width/13,
//                                 fontWeight: FontWeight.bold

//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 _raiting = Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.solidStar,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           gradient: LinearGradient(begin: Alignment.bottomRight,
//                               // end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(.9),
//                                 Colors.black.withOpacity(.1)
//                               ]),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               buildPhotoURL(photos[index].photoReference)),
//                           fit: BoxFit.cover,
//                         ),
//                         // gradient: LinearGradient(begin: Alignment.bottomRight,
//                         //     // end: Alignment.topCenter,
//                         //     colors: [
//                         //       Colors.black.withOpacity(.9),
//                         //       Colors.black.withOpacity(.1)
//                         //     ]),
//                       ),
//                       // child: Image.network(
//                       //   buildPhotoURL(photos[index].photoReference),
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                   );
//                 })));
//       }
//     }
//     if (placeDetail.formattedAddress != null) {
//       list.add(
//         Padding(
//             padding: EdgeInsets.only(top: 30.0, left: 20.0, bottom: 15.0),
//             child: Row(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Container(
//                       height: MediaQuery.of(context).size.height / 15,
//                       width: MediaQuery.of(context).size.width / 7.4,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[500],
//                             offset: Offset(5.0, 5.0),
//                             blurRadius: 15.0,
//                             spreadRadius: 1.0,
//                           ),
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(-5.0, -5.0),
//                             blurRadius: 15.0,
//                             spreadRadius: 1.0,
//                           )
//                         ],
//                       ),
//                       child: Icon(
//                         FontAwesomeIcons.mapMarkerAlt,
//                         color: Color(0xff3b6978),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 15,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           placeDetail.types.first.toUpperCase(),
//                           style: TextStyle(
//                               letterSpacing: 3,
//                               color: Color(0xff10375c),
//                               fontFamily: 'calibri',
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height / 250,
//                         ),
//                         Text(
//                           placeDetail.formattedAddress,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: 'calibri',
//                             fontSize: 15,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//       );
//     }
//     // if (placeDetail.formattedAddress != null) {
//     //   list.add(
//     //     Padding(
//     //         padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
//     //         child: Row(
//     //           children: <Widget>[
//     //             Container(
//     //               height: MediaQuery.of(context).size.height / 15,
//     //               width: MediaQuery.of(context).size.width / 7.4,
//     //               decoration: BoxDecoration(
//     //                 color: Colors.grey[300],
//     //                 borderRadius: BorderRadius.all(Radius.circular(10)),
//     //                 boxShadow: [
//     //                   BoxShadow(
//     //                     color: Colors.grey[500],
//     //                     offset: Offset(5.0, 5.0),
//     //                     blurRadius: 15.0,
//     //                     spreadRadius: 1.0,
//     //                   ),
//     //                   BoxShadow(
//     //                     color: Colors.white,
//     //                     offset: Offset(-5.0, -5.0),
//     //                     blurRadius: 15.0,
//     //                     spreadRadius: 1.0,
//     //                   )
//     //                 ],
//     //               ),
//     //               child: Icon(
//     //                 FontAwesomeIcons.mapMarkerAlt,
//     //                 color: Color(0xff3b6978),
//     //               ),
//     //             ),
//     //             SizedBox(
//     //               width: MediaQuery.of(context).size.width / 15,
//     //             ),
//     //             Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: <Widget>[
//     //                 Text(
//     //                   'Destination',
//     //                   style: TextStyle(
//     //                       letterSpacing: 3,
//     //                       color: Color(0xff10375c),
//     //                       fontFamily: 'calibri',
//     //                       fontSize: 20,
//     //                       fontWeight: FontWeight.bold),
//     //                 ),
//     //                 SizedBox(height: MediaQuery.of(context).size.height / 250),
//     //                 Text(
//     //                   placeDetail.formattedAddress,
//     //                   style: TextStyle(
//     //                     color: Colors.black,
//     //                     fontFamily: 'calibri',
//     //                     fontSize: 15,
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ],
//     //         )),
//     //   );
//     // }

//     // if (placeDetail.types?.first != null) {
//     //   list.add(
//     //     Padding(
//     //         padding:
//     //             EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 0.0),
//     //         child: Text(
//     //           placeDetail.types.first.toUpperCase(),
//     //           style: Theme.of(context).textTheme.caption,
//     //         )),
//     //   );
//     // }

//     if (placeDetail.formattedPhoneNumber != null) {
//       list.add(
//         Padding(
//             padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height / 15,
//                   width: MediaQuery.of(context).size.width / 7.4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[500],
//                         offset: Offset(5.0, 5.0),
//                         blurRadius: 15.0,
//                         spreadRadius: 1.0,
//                       ),
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: Offset(-5.0, -5.0),
//                         blurRadius: 15.0,
//                         spreadRadius: 1.0,
//                       )
//                     ],
//                   ),
//                   child: Icon(
//                     FontAwesomeIcons.phoneAlt,
//                     color: Color(0xff3b6978),
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 15,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Phone',
//                       style: TextStyle(
//                           letterSpacing: 3,
//                           color: Color(0xff10375c),
//                           fontFamily: 'calibri',
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 250),
//                     Text(
//                       placeDetail.formattedPhoneNumber,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'calibri',
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//       );
//     }

//     if (placeDetail.openingHours != null) {
//       final openingHour = placeDetail.openingHours;
//       var text = '';
//       if (openingHour.openNow) {
//         text = 'Opening Now';
//         _close = Icon(
//           FontAwesomeIcons.storeAlt,
//           color: Color(0xff3b6978),
//         );
//       } else {
//         text = 'Closed';
//         _close = Icon(
//           FontAwesomeIcons.storeSlash,
//           color: Color(0xff3b6978),
//         );
//       }
//       list.add(
//         Padding(
//             padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
//             child: Row(
//               children: <Widget>[
//                 Container(
//                     height: MediaQuery.of(context).size.height / 15,
//                     width: MediaQuery.of(context).size.width / 7.4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[500],
//                           offset: Offset(5.0, 5.0),
//                           blurRadius: 15.0,
//                           spreadRadius: 1.0,
//                         ),
//                         BoxShadow(
//                           color: Colors.white,
//                           offset: Offset(-5.0, -5.0),
//                           blurRadius: 15.0,
//                           spreadRadius: 1.0,
//                         )
//                       ],
//                     ),
//                     child: _close),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 15,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Open ?',
//                       style: TextStyle(
//                           letterSpacing: 3,
//                           color: Color(0xff10375c),
//                           fontFamily: 'calibri',
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 250),
//                     Text(
//                       text,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'calibri',
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//       );
//     }

//     if (placeDetail.website != null) {
//       list.add(
//         Padding(
//             padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height / 15,
//                   width: MediaQuery.of(context).size.width / 7.4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[500],
//                         offset: Offset(5.0, 5.0),
//                         blurRadius: 15.0,
//                         spreadRadius: 1.0,
//                       ),
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: Offset(-5.0, -5.0),
//                         blurRadius: 15.0,
//                         spreadRadius: 1.0,
//                       )
//                     ],
//                   ),
//                   child: Icon(
//                     FontAwesomeIcons.globe,
//                     color: Color(0xff3b6978),
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 15,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'WebSite',
//                       style: TextStyle(
//                           letterSpacing: 3,
//                           color: Color(0xff10375c),
//                           fontFamily: 'calibri',
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 250),
//                     Text(
//                       placeDetail.website,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'calibri',
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )),
//       );
//     }
//     // if (placeDetail.rating != null) {
//     //   if (placeDetail.rating == 1) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   if (placeDetail.rating > 1 && placeDetail.rating < 1.5 ||
//     //       placeDetail.rating > 1.5 && placeDetail.rating < 2) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.starHalfAlt,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   // if (placeDetail.rating > 1.5 && placeDetail.rating < 2) {}
//     //   if (placeDetail.rating == 2) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   if (placeDetail.rating > 2 && placeDetail.rating < 2.5 ||
//     //       placeDetail.rating > 2.5 && placeDetail.rating < 3) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.starHalfAlt,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   // if (placeDetail.rating > 2.5 && placeDetail.rating < 3) {}
//     //   if (placeDetail.rating == 3) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   if (placeDetail.rating > 3 && placeDetail.rating < 3.5 ||
//     //       placeDetail.rating > 3.5 && placeDetail.rating < 4) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.starHalfAlt,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   // if (placeDetail.rating > 3.5 && placeDetail.rating < 4) {}
//     //   if (placeDetail.rating == 4) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.star,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   if (placeDetail.rating > 4 && placeDetail.rating < 4.5 ||
//     //       placeDetail.rating > 4.5 && placeDetail.rating < 5) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.starHalfAlt,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }
//     //   // if (placeDetail.rating > 4.5 && placeDetail.rating < 5) {}
//     //   if (placeDetail.rating == 5) {
//     //     list.add(
//     //       Padding(
//     //           padding:
//     //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //           child: Row(
//     //             children: <Widget>[
//     //               _raiting = Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //               Icon(
//     //                 FontAwesomeIcons.solidStar,
//     //                 color: Colors.amber,
//     //               ),
//     //             ],
//     //           )),
//     //     );
//     //   }

//     //   // list.add(
//     //   //   Padding(
//     //   //       padding:
//     //   //           EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
//     //   //       child: Text(
//     //   //         "Rating: ${placeDetail.rating}",
//     //   //         style: Theme.of(context).textTheme.caption,
//     //   //       )),
//     //   // );
//     // }

//     list.add(
//       Padding(
//         padding: EdgeInsets.only(top: 20.0),
//         child: Center(
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             height: MediaQuery.of(context).size.height / 13,
//             width: withAnimatedBtn,
//             decoration: BoxDecoration(
//               color: backBtn,
//               borderRadius: BorderRadius.all(Radius.circular(70)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey[500],
//                   offset: Offset(5.0, 5.0),
//                   blurRadius: 15.0,
//                   spreadRadius: 1.0,
//                 ),
//                 BoxShadow(
//                   color: Colors.white,
//                   offset: Offset(-5.0, -5.0),
//                   blurRadius: 15.0,
//                   spreadRadius: 1.0,
//                 )
//               ],
//             ),
//             child: IconButton(
//                 icon: _icon,
//                 iconSize: 30,
//                 onPressed: () {
//                   setState(() {
//                     withAnimatedBtn = 80;
//                     backBtn = Color(0xff10375c);
//                     _icon = Icon(
//                       FontAwesomeIcons.check,
//                       color: Colors.white,
//                     );
//                   });
//                 }),
//           ),
//         ),
//       ),
//     );
//     return ListView(
//       shrinkWrap: true,
//       children: list,
//     );
//   }
// }

import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Animation/FadeAnimationmataht.dart';
import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

final DateTime dateTime = DateTime.now();

const kGoogleApiKey = 'API';
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class DetaiPlace extends StatefulWidget {
  String placeId;
  DetaiPlace(String placeId) {
    this.placeId = placeId;
  }

  @override
  _DetaiPlaceState createState() => _DetaiPlaceState();
}

class _DetaiPlaceState extends State<DetaiPlace>
    with SingleTickerProviderStateMixin {
  GoogleMapController mapController;
  PlacesDetailsResponse place;
  bool isLoading = false;
  String errorLoading;
  String ref;
  String idPlaces;

  double withAnimatedBtn = 170;
  Icon _icon = Icon(
    FontAwesomeIcons.plus,
    color: Color(0xFFc5426e),
  );
  Color backBtn = Colors.grey[300];
  Icon _close = Icon(FontAwesomeIcons.storeSlash,color: Color(0xFFc5426e),);
  bool _heart = true;

  Animation animation;
  AnimationController animationController;
  bool reverSinimation = false;
  int ratinghist = 0;

  bool exixte = false;

  GoogleMapController _controller;
  var geolocator = Geolocator();
  double latD, longD;
  double latt;
  double lang;
  double distance = 0.0;
  String timeE = 'OO';

  int he = 0;
  int min = 0;

  int d = DateTime.now().weekday;

  void animated() {
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  void initState() {
    // uidPlaces();
    fetchPlaceDetail();

    // getPlace();
    super.initState();
    // _getCur();

    Future.delayed(Duration(seconds: 1), () {
      _getCur();
    });
  }
// latD, longD, latt, lang)

  void _getCur() async {
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

    // double vV = distance/20;
    // print(vV);
    // double vL = distance/80;
    // print(vL);
  }

  String buildPhotoURL(String photoReference) {
    ref = photoReference;
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
  }

  // void uidPlaces() async {
  //   DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(uiiid).collection('places').document().get();
  //   idPlaces = snapshot.documentID;

  // }
  // void _getCur() async {
  //   final position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   // HADI BAH NHAWAL CAMIRA NDIRHA HAKA
  //   // _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //   //   target: LatLng(position.latitude, position.longitude),
  //   //   zoom: 16.0,
  //   // )));

  //   latD = position.latitude;
  //   longD = position.longitude;
  //   print('Lat :' + latD.toString());
  //   print('Long :' + longD.toString());
  // }

  @override
  Widget build(BuildContext context) {
    String idplaceF ;
    String namePlace = "";
    String formAddress = "";
    String type = "";
    String phoneNumber = "";
    // var mahlolwalaMbala3;
    String mahlolMbalaa = "";
    String siteWeb = "";
    // double rating = 0.0;
    double count;
    bool notNul = false;
    String opning = "";
    Widget listePPP;
    // double latt;
    // double lang;
    Widget bodyChild;
    // String title;

    if (isLoading) {
      namePlace = "Loading";
      bodyChild = Center(
        child: CircularProgressIndicator(
          value: null,
        ),
      );
    } else if (errorLoading != null) {
      namePlace = "";
      bodyChild = Center(
        child: Text(errorLoading),
      );
    } else {
      final placeDetail = place.result;
      final location = place.result.geometry.location;
      final lat = location.lat;
      latt = lat;
      final lng = location.lng;
      lang = lng;
      final center = LatLng(lat, lng);

      namePlace = placeDetail.name;
      idplaceF = placeDetail.id;

      void getPostplace() async{
          Firestore.instance
            .collection('users')
            .document(uiiid)
            .collection('places')
            .document()
            .setData({
          'name': namePlace,
          'type': type,
          'address': formAddress,
          'open': mahlolMbalaa,
          'siteweb': siteWeb,
          'phone': phoneNumber,
          'latitud': latt.toString(),
          'longutude': lang.toString(),
          'rating': "${placeDetail.rating}",
          'photo': ref,
          'date': dateTime,
          'ratinghist': ratinghist,
        });
        // _getCur();

       
      }
      void getFavorite()async{
        bool kayan =false;
        final QuerySnapshot snapshot = await Firestore.instance.collection('users').document(uiiid).collection('favorites').where('id',isEqualTo:idplaceF.toString()).getDocuments();
        snapshot.documents.forEach(
          (DocumentSnapshot doc){
            kayan=true;
          }
        );
        if(kayan){
          print('rah kayan ');
        }else{
          Firestore.instance
            .collection('users')
            .document(uiiid)
            .collection('favorites')
            .document()
            .setData({
          'id': idplaceF,
          'name': namePlace,
          'type': type,
          'address': formAddress,
          'open': mahlolMbalaa,
          'siteweb': siteWeb,
          'phone': phoneNumber,
          'latitud': latt.toString(),
          'longutude': lang.toString(),
          'rating': "${placeDetail.rating}",
          'photo': ref,
          'date': dateTime,
          'ratinghist': ratinghist,
        });
        }
      }

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
        // mahlolwalaMbala3 = '';
        if (openFer.openNow) {
          mahlolMbalaa = 'Opening Now';
          // print('Opening Now');
          _close = Icon(
            FontAwesomeIcons.storeAlt,
            color: Color(0xFFc5426e),
          );
        } else {
          mahlolMbalaa = 'Close';
          _close = Icon(
            FontAwesomeIcons.storeSlash,
            color: Color(0xFFc5426e),
          );
        }
      }
      if (placeDetail.website != null) {
        siteWeb = placeDetail.website;
      }
      if (placeDetail.openingHours != null) {
        var h = placeDetail.openingHours.weekdayText[d - 1];
        int hh = h.indexOf(' ');
        opning = h.substring(hh + 1);
        // print(h.substring(hh+1));
      }
      if (placeDetail.photos != null && placeDetail.rating != null) {
        final photos = placeDetail.photos;
        // count = photos.length;
        if (placeDetail.rating == 1) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        Text(
                          namePlace,
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
                          type,
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
                            )
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
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating > 1 && placeDetail.rating < 1.5 ||
            placeDetail.rating > 1.5 && placeDetail.rating < 2) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        Text(
                          namePlace,
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
                          type,
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
                            )
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
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.starHalfAlt,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating == 2) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        Text(
                          namePlace,
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
                          type,
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
                                  fontSize: 14),
                            )
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
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating > 2 && placeDetail.rating < 2.5 ||
            placeDetail.rating > 2.5 && placeDetail.rating < 3) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        Text(
                          namePlace,
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
                          type,
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
                            )
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
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.starHalfAlt,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating == 3) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        Text(
                          namePlace,
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
                          type,
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
                            )
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
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating > 3 && placeDetail.rating < 3.5 ||
            placeDetail.rating > 3.5 && placeDetail.rating < 4) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        Text(
                          namePlace,
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
                          type,
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
                            )
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
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.starHalfAlt,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating == 4) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Text(
                          namePlace,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'BalooTamma2 Bold',
                              fontSize: MediaQuery.of(context).size.width / 15),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${placeDetail.rating}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
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
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating > 4 && placeDetail.rating < 4.5 ||
            placeDetail.rating > 4.5 && placeDetail.rating < 5) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Text(
                          namePlace,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'BalooTamma2 Bold',
                              fontSize: MediaQuery.of(context).size.width / 15),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${placeDetail.rating}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
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
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
        if (placeDetail.rating == 5) {
          listePPP = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            IconButton(
                              icon: _heart
                                  ? Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Color(0xFFc5426e),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                                getFavorite();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        FadeAnimation(1.4, Text(
                          namePlace,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'GothamRoundedMedium_21022',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 15),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        FadeAnimation(1.6, Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'GothamRoundedLight 21020',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        FadeAnimation(1.8, Row(
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
                            )
                          ],
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        FadeAnimation(2, Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Color(0xFFc5426e),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${placeDetail.rating}',
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
                                          MediaQuery.of(context).size.width /
                                              30),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 60,
                            // ),
                          ],
                        )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomRight,
                          // end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.1)
                          ]),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover)),
                  // child: Image.network(
                  //   buildPhotoURL(photos[index].photoReference),
                  // ),
                ),
              );
            },
          );
        }
      }
      bodyChild = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: double.infinity,
              child: Container(
                child: listePPP,
              ),
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
                      FadeAnimationmataht(
                          1.5,
                          Row(
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
                                    ' ' + phoneNumber,
                                    style: TextStyle(
                                        letterSpacing: 3,
                                        color: Color(0xFF212121),
                                        fontFamily: 'GothamRoundedLight 21020',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        250,
                                  ),
                                  Text(
                                    placeDetail.formattedAddress,
                                    style: TextStyle(
                                      color: Color(0xFF212121),
                                      fontFamily: 'GothamRoundedMedium_21022',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      FadeAnimationmataht(
                          2,
                          Row(
                            children: <Widget>[
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width:
                                      MediaQuery.of(context).size.width / 7.4,
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
                                    '  ' + mahlolMbalaa,
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
                                          fontFamily:
                                              'GothamRoundedMedium_21022',
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        opning,
                                        style: TextStyle(
                                          color: Color(0xff212121),
                                          fontFamily:
                                              'GothamRoundedMedium_21022',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      FadeAnimationmataht(
                          1.8,
                          Center(
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
                                    // _getCur();
                                    getPostplace();
                                  }),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: bodyChild,
    );
  }

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
}

//  decoration: BoxDecoration(
//    borderRadius: BorderRadius.all(Radius.circular(50)),
//    image: DecorationImage(
//      image: NetworkImage(
//          buildPhotoURL(photos[index].photoReference)),
//      fit: BoxFit.cover,
//    ),

// child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//   itemCount: photos.length,
//   itemBuilder: (context, index) {
//       return Padding(
//         padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
//       child: Container(
//           width: MediaQuery.of(context).size.width / 1.1,
//         child: Container(
//             padding: const EdgeInsets.all(30),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//                 Text(
//                   placeDetail.name,
//                 style: TextStyle(
//                     color: Colors.white,
//                   letterSpacing: 2,
//                   fontFamily: 'BalooTamma2 Bold',
//                   fontSize: MediaQuery.of(context).size.width/13,
//                   fontWeight: FontWeig
//                 ),
