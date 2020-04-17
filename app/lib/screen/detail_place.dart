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
import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Icon _icon = Icon(FontAwesomeIcons.plus);
  Color backBtn = Colors.grey[300];
  Icon _close;
  bool _heart = true;

  Animation animation;
  AnimationController animationController;
  bool reverSinimation = false;
  int ratinghist = 0;

  bool exixte = false;

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
  }

  String buildPhotoURL(String photoReference) {
    ref = photoReference;
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
  }

  // getPlace(){
  //   Firestore.instance.collection('users').document(uiiid).collection('places').getDocuments().then(
  //     (QuerySnapshot snapshot){
  //       snapshot.documents.forEach(
  //         (DocumentSnapshot doc){
  //           // print(doc.data);
  //           exixte = doc.exists ;
  //           print(doc.exists);
  //         }
  //       );
  //     }
  //   );

  // }
  // void uidPlaces() async {
  //   DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(uiiid).collection('places').document().get();
  //   idPlaces = snapshot.documentID;
    
  // }

  @override
  Widget build(BuildContext context) {
    String namePlace = "";
    String formAddress = "";
    String type = "";
    String phoneNumber = "";
    // var mahlolwalaMbala3;
    String mahlolMbalaa = "";
    String siteWeb = "";
    // double rating = 0.0;
    double count;
    double latt;
    double lang;
    bool notNul = false;
    Widget listePPP;

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

      void getPostplace() {
        
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
            color: Color(0xff3b6978),
          );
        } else {
          mahlolMbalaa = 'Close';
          // print('Close');
          _close = Icon(
            FontAwesomeIcons.storeSlash,
            color: Color(0xff3b6978),
          );
        }
      }
      if (placeDetail.website != null) {
        siteWeb = placeDetail.website;
      }
      // if (placeDetail.rating != null) {
      //   rating = placeDetail.rating;
      // }
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Text(
                          namePlace,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'BalooTamma2 Bold',
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: <Widget>[
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
                            Icon(
                              FontAwesomeIcons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
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
                        )
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.starHalfAlt,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
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
                        )
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
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
                              FontAwesomeIcons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
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
                        )
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
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
                              FontAwesomeIcons.starHalfAlt,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.star,
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
                        )
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
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
                              FontAwesomeIcons.star,
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
                        )
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4.5,
                        ),
                        Text(
                          namePlace,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'BalooTamma2 Bold',
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
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
                              FontAwesomeIcons.starHalfAlt,
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
                        )
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
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
                        )
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        Row(
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
                              FontAwesomeIcons.starHalfAlt,
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
                        )
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
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _heart = false;
                                });
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
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontFamily: 'BalooTamma2 Bold',
                            fontSize: 20,
                          ),
                        ),
                        FadeAnimation(
                            2,
                            Row(
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
                                  FontAwesomeIcons.solidStar,
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
                            ))
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
                offset: Offset(0, -32),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.5,
                          Row(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 7.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                  color: Color(0xff3b6978),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    phoneNumber,
                                    style: TextStyle(
                                        letterSpacing: 3,
                                        color: Color(0xff10375c),
                                        fontFamily: 'calibri',
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
                                      color: Colors.black,
                                      fontFamily: 'calibri',
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
                      FadeAnimation(
                          1.6,
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
                                        BorderRadius.all(Radius.circular(10)),
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
                                    'Open ?',
                                    style: TextStyle(
                                        letterSpacing: 3,
                                        color: Color(0xff10375c),
                                        fontFamily: 'calibri',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        250,
                                  ),
                                  Text(
                                    mahlolMbalaa,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'calibri',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      FadeAnimation(
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
                                      backBtn = Color(0xff10375c);
                                      _icon = Icon(
                                        FontAwesomeIcons.check,
                                        color: Colors.white,
                                      );
                                    });
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
