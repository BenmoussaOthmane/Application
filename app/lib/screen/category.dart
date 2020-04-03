import 'package:app/screen/Home.dart';
import 'package:app/screen/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Category extends StatefulWidget {
  static final String id = 'category';
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  bool darkCaf = true;
  bool darkRest = true;
  bool darkShop = true;
  bool darkVet = true;
  bool darkBotique = true;
  bool darkTelphone = true;

  int caf;
  int rest;
  int shop;
  int vet;
  int botique;
  int telphone;

  int vall = 1;

  AnimationController _animationController;
  Animation<double> _animation;
  bool hide = true;

  double _kM = 0.0;
  double _min = 0.0;
  double _max = 100.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 30.0,
    ).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.downToUp, child: Onboarding()));
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void getSterted(BuildContext context) {
    if (caf != null &&
        rest != null &&
        shop != null &&
        vet != null &&
        botique != null &&
        telphone != null) {
      print('cafe= ' +
          caf.toString() +
          ' rest= ' +
          rest.toString() +
          ' shoping= ' +
          shop.toString() +
          ' vet= ' +
          vet.toString() +
          ' botique= ' +
          botique.toString() +
          ' tel= ' +
          telphone.toString() +
          ' KM= ' +
          _kM.toString());
      _animationController.forward();
    } else {
      SnackBar mys = SnackBar(
        backgroundColor: Color(0xff204051),
        duration: Duration(milliseconds: 700),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
          child: Text(
            'khasak t3amar ga3 swalhak',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(mys);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Category',
                style: TextStyle(
                    color: Color(0xff084177),
                    fontFamily: 'calibri',
                    letterSpacing: 4,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Text(
                'Some of the places you love will be shown based on your selection of these items',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'calibri',
                    fontSize: 15,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.local_cafe,
                        size: 35,
                        color: darkCaf ? Color(0xff84a9ac) : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          darkCaf = false;
                          caf = vall;
                          vall++;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: darkCaf
                          ? Colors.grey[300]
                          : Color(0xff84a9ac).withOpacity(.8),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: IconButton(
                      icon: Icon(
                        Icons.restaurant,
                        size: 35,
                        color: darkRest ? Color(0xff3b6978) : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          darkRest = false;
                          rest = vall;
                          vall++;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: darkRest
                          ? Colors.grey[300]
                          : Color(0xff3b6978).withOpacity(.6),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.store,
                        size: 35,
                        color: darkShop ? Color(0xff235952) : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          darkShop = false;
                          shop = vall;
                          vall++;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: darkShop
                          ? Colors.grey[300]
                          : Color(0xff235952).withOpacity(.6),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_basket,
                        size: 35,
                        color: darkVet ? Color(0xff7d5e2a) : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          darkVet = false;
                          vet = vall;
                          vall++;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: darkVet
                          ? Colors.grey[300]
                          : Color(0xff7d5e2a).withOpacity(.6),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: IconButton(
                      icon: Icon(
                        Icons.new_releases,
                        size: 35,
                        color: darkBotique ? Color(0xff512b58) : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          darkBotique = false;
                          botique = vall;
                          vall++;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: darkBotique
                          ? Colors.grey[300]
                          : Color(0xff512b58).withOpacity(.6),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.smartphone,
                        size: 35,
                        color: darkTelphone ? Colors.green[300] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          darkTelphone = false;
                          telphone = vall;
                          vall++;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color:
                          darkTelphone ? Colors.grey[300] : Colors.green[200],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                'Mileage',
                style: TextStyle(
                    color: Color(0xff084177),
                    fontFamily: 'calibri',
                    letterSpacing: 4,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Text(
                'Some of the places you love will be shown based on your selection of these items',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'calibri',
                    fontSize: 15,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              Container(
                child: Slider(
                  value: _kM,
                  min: _min,
                  max: _max,
                  divisions: 10,
                  activeColor: Color(0xff204051),
                  inactiveColor: Color(0xff3b6978),
                  label: '$_kM',
                  onChanged: (double valeau) {
                    setState(() {
                      _kM = valeau.roundToDouble();
                      // print(_kM);
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 32,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '$_kM',
                    style: TextStyle(
                        color: Color(0xff204051),
                        fontFamily: 'calibri',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 45,
                  ),
                  Text(
                    'KM',
                    style: TextStyle(
                        color: Color(0xff204051),
                        fontFamily: 'calibri',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.scale(
                      scale: _animation.value,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            size: 50,
                            color: Color(0xff204051),
                          ),
                          onPressed: () {
                            setState(() {
                              hide = true;
                            });
                            getSterted(context);
                          },
                          // child: Text(
                          //   'Get Started',
                          //   style: TextStyle(
                          //       letterSpacing: 2,
                          //       color: Color(0xff084177),
                          //       fontFamily: 'calibri',
                          //       fontSize: 21,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
