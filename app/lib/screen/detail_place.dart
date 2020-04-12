import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "API";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class DetaiPlace extends StatefulWidget {
  String placeId;

  DetaiPlace(String placeId) {
    this.placeId = placeId;
  }

  @override
  State<StatefulWidget> createState() {
    return PlaceDetailState();
  }
}

class PlaceDetailState extends State<DetaiPlace>
    with SingleTickerProviderStateMixin {
  GoogleMapController mapController;
  PlacesDetailsResponse place;
  bool isLoading = false;
  String errorLoading;

  double withAnimatedBtn = 170;
  Icon _icon = Icon(FontAwesomeIcons.plus);
  Color backBtn = Colors.grey[300];
  Icon _close;
  Icon _raiting;

  Animation animation;
  AnimationController animationController;
  bool reverSinimation = false;

  void animated() {
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  void initState() {
    fetchPlaceDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyChild;
    String title;
    if (isLoading) {
      title = "Loading";
      bodyChild = Center(
        child: CircularProgressIndicator(
          value: null,
        ),
      );
    } else if (errorLoading != null) {
      title = "";
      bodyChild = Center(
        child: Text(errorLoading),
      );
    } else {
      final placeDetail = place.result;
      final location = place.result.geometry.location;
      final lat = location.lat;
      final lng = location.lng;
      final center = LatLng(lat, lng);

      title = placeDetail.name;
      bodyChild = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Container(
          //     child: SizedBox(
          //   height: 200.0,
          //   child: GoogleMap(
          //     // onMapCreated: _onMapCreated,
          //     initialCameraPosition: CameraPosition(
          //     bearing: 192.8334901395799,
          //     target: LatLng(0, 0),
          //     zoom: 16,
          //   ),
          //   ),
          // )),
          Expanded(
            child: buildPlaceDetailList(placeDetail),
          )
        ],
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          leading: IconButton(
              icon:
                  Icon(FontAwesomeIcons.chevronLeft, color: Color(0xff10375c)),
              onPressed: () => Navigator.pop(context)),
          title: Text(
            title,
            style: TextStyle(
                color: Color(0xff10375c),
                letterSpacing: 3,
                fontFamily: 'calibri',
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.heart,
                  color: Color(0xff10375c),
                ),
                onPressed: null)
          ],
        ),
        body: bodyChild);
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

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  //   final placeDetail = place.result;
  //   final location = place.result.geometry.location;
  //   final lat = location.lat;
  //   final lng = location.lng;
  //   final center = LatLng(lat, lng);
  //   var markerOptions = MarkerOptions(
  //       position: center,
  //       infoWindowText: InfoWindowText(
  //           "${placeDetail.name}", "${placeDetail.formattedAddress}"));
  //   mapController.addMarker(markerOptions);
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: center, zoom: 15.0)));
  // }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
  }

  ListView buildPlaceDetailList(PlaceDetails placeDetail) {
    List<Widget> list = [];
    if (placeDetail.photos != null && placeDetail.photos != null) {
      final photos = placeDetail.photos;
      if (placeDetail.rating ==1) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating >1 && placeDetail.rating <1.5 || placeDetail.rating >1.5 && placeDetail.rating <2) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating ==2) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating >2 && placeDetail.rating <2.5 || placeDetail.rating >2.5 && placeDetail.rating <3 ) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating ==3) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating >3 && placeDetail.rating <3.5 || placeDetail.rating >3.5 && placeDetail.rating <4 ) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              placeDetail.name,
                              style: TextStyle(
                                color: Colors.grey[400],
                                letterSpacing: 2,
                                fontFamily: 'calibri',
                                fontSize: MediaQuery.of(context).size.width/13,
                                fontWeight: FontWeight.bold

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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating ==4 ) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating >4 && placeDetail.rating <4.5 || placeDetail.rating >4.5 && placeDetail.rating <5 ) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
      if (placeDetail.rating ==5 ) {
        list.add(SizedBox(
            height: 280.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _raiting = Icon(
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
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(begin: Alignment.bottomRight,
                              // end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.9),
                                Colors.black.withOpacity(.1)
                              ]),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              buildPhotoURL(photos[index].photoReference)),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(begin: Alignment.bottomRight,
                        //     // end: Alignment.topCenter,
                        //     colors: [
                        //       Colors.black.withOpacity(.9),
                        //       Colors.black.withOpacity(.1)
                        //     ]),
                      ),
                      // child: Image.network(
                      //   buildPhotoURL(photos[index].photoReference),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  );
                })));
      }
    }
    if (placeDetail.formattedAddress != null) {
      list.add(
        Padding(
            padding: EdgeInsets.only(top: 30.0, left: 20.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 7.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        FontAwesomeIcons.mapMarkerAlt,
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
                          placeDetail.types.first.toUpperCase(),
                          style: TextStyle(
                              letterSpacing: 3,
                              color: Color(0xff10375c),
                              fontFamily: 'calibri',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 250,
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
                    ),
                  ],
                ),
              ],
            )),
      );
    }
    // if (placeDetail.formattedAddress != null) {
    //   list.add(
    //     Padding(
    //         padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
    //         child: Row(
    //           children: <Widget>[
    //             Container(
    //               height: MediaQuery.of(context).size.height / 15,
    //               width: MediaQuery.of(context).size.width / 7.4,
    //               decoration: BoxDecoration(
    //                 color: Colors.grey[300],
    //                 borderRadius: BorderRadius.all(Radius.circular(10)),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.grey[500],
    //                     offset: Offset(5.0, 5.0),
    //                     blurRadius: 15.0,
    //                     spreadRadius: 1.0,
    //                   ),
    //                   BoxShadow(
    //                     color: Colors.white,
    //                     offset: Offset(-5.0, -5.0),
    //                     blurRadius: 15.0,
    //                     spreadRadius: 1.0,
    //                   )
    //                 ],
    //               ),
    //               child: Icon(
    //                 FontAwesomeIcons.mapMarkerAlt,
    //                 color: Color(0xff3b6978),
    //               ),
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width / 15,
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   'Destination',
    //                   style: TextStyle(
    //                       letterSpacing: 3,
    //                       color: Color(0xff10375c),
    //                       fontFamily: 'calibri',
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //                 SizedBox(height: MediaQuery.of(context).size.height / 250),
    //                 Text(
    //                   placeDetail.formattedAddress,
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontFamily: 'calibri',
    //                     fontSize: 15,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         )),
    //   );
    // }

    // if (placeDetail.types?.first != null) {
    //   list.add(
    //     Padding(
    //         padding:
    //             EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 0.0),
    //         child: Text(
    //           placeDetail.types.first.toUpperCase(),
    //           style: Theme.of(context).textTheme.caption,
    //         )),
    //   );
    // }

    if (placeDetail.formattedPhoneNumber != null) {
      list.add(
        Padding(
            padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 7.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    FontAwesomeIcons.phoneAlt,
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
                      'Phone',
                      style: TextStyle(
                          letterSpacing: 3,
                          color: Color(0xff10375c),
                          fontFamily: 'calibri',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 250),
                    Text(
                      placeDetail.formattedPhoneNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'calibri',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    }

    if (placeDetail.openingHours != null) {
      final openingHour = placeDetail.openingHours;
      var text = '';
      if (openingHour.openNow) {
        text = 'Opening Now';
        _close = Icon(
          FontAwesomeIcons.storeAlt,
          color: Color(0xff3b6978),
        );
      } else {
        text = 'Closed';
        _close = Icon(
          FontAwesomeIcons.storeSlash,
          color: Color(0xff3b6978),
        );
      }
      list.add(
        Padding(
            padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 7.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    SizedBox(height: MediaQuery.of(context).size.height / 250),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'calibri',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    }

    if (placeDetail.website != null) {
      list.add(
        Padding(
            padding: EdgeInsets.only(top: 2.0, left: 20.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 7.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      'WebSite',
                      style: TextStyle(
                          letterSpacing: 3,
                          color: Color(0xff10375c),
                          fontFamily: 'calibri',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 250),
                    Text(
                      placeDetail.website,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'calibri',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    }
    // if (placeDetail.rating != null) {
    //   if (placeDetail.rating == 1) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   if (placeDetail.rating > 1 && placeDetail.rating < 1.5 ||
    //       placeDetail.rating > 1.5 && placeDetail.rating < 2) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.starHalfAlt,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   // if (placeDetail.rating > 1.5 && placeDetail.rating < 2) {}
    //   if (placeDetail.rating == 2) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   if (placeDetail.rating > 2 && placeDetail.rating < 2.5 ||
    //       placeDetail.rating > 2.5 && placeDetail.rating < 3) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.starHalfAlt,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   // if (placeDetail.rating > 2.5 && placeDetail.rating < 3) {}
    //   if (placeDetail.rating == 3) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   if (placeDetail.rating > 3 && placeDetail.rating < 3.5 ||
    //       placeDetail.rating > 3.5 && placeDetail.rating < 4) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.starHalfAlt,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   // if (placeDetail.rating > 3.5 && placeDetail.rating < 4) {}
    //   if (placeDetail.rating == 4) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.star,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   if (placeDetail.rating > 4 && placeDetail.rating < 4.5 ||
    //       placeDetail.rating > 4.5 && placeDetail.rating < 5) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.starHalfAlt,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    //   // if (placeDetail.rating > 4.5 && placeDetail.rating < 5) {}
    //   if (placeDetail.rating == 5) {
    //     list.add(
    //       Padding(
    //           padding:
    //               EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //           child: Row(
    //             children: <Widget>[
    //               _raiting = Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //               Icon(
    //                 FontAwesomeIcons.solidStar,
    //                 color: Colors.amber,
    //               ),
    //             ],
    //           )),
    //     );
    //   }

    //   // list.add(
    //   //   Padding(
    //   //       padding:
    //   //           EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 4.0),
    //   //       child: Text(
    //   //         "Rating: ${placeDetail.rating}",
    //   //         style: Theme.of(context).textTheme.caption,
    //   //       )),
    //   // );
    // }

    list.add(
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height / 13,
            width: withAnimatedBtn,
            decoration: BoxDecoration(
              color: backBtn,
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
                    backBtn = Color(0xff10375c);
                    _icon = Icon(
                      FontAwesomeIcons.check,
                      color: Colors.white,
                    );
                  });
                }),
          ),
        ),
      ),
    );
    return ListView(
      shrinkWrap: true,
      children: list,
    );
  }
}
