import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/Constants/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:liquid_swipe/page.dart';

class Onboarding extends StatefulWidget {
  static final String id = 'onboarding';
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // final int _numpage = 3;
  // final PageController _pagecontroller = PageController(initialPage: 0);
  // int _currentPage = 0;

  // List <Widget> _buildPageIndicator(){
  //   List<Widget> list = [];
  //   for(int i = 0; i < _numpage ; i++){
  //     list.add( i == _currentPage ? _indicator(true) : _indicator(false));
  //   }
  //   return list;
  // }
  // Widget _indicator( bool isActive ){
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 300),
  //     margin: EdgeInsets.symmetric(horizontal: 8.0),
  //     height: 8.0,
  //     width: isActive ? 24.0 : 16.0,
  //     decoration: BoxDecoration(
  //       color: isActive ? Color.fromRGBO(7, 206, 250,100) : Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //     ),
  //   );
  // }
  bool buttonPressed1 = false;
  bool buttonPressed2 = false;
  void _letsPress1() {
    setState(() {
      buttonPressed1 = true;
      buttonPressed2 = false;
    });
  }

  void _letsPress2() {
    setState(() {
      buttonPressed1 = false;
      buttonPressed2 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.1,
                  // 0.3,
                  0.6,
                  1.0
                ],
                colors: [
                  Color(0xFFc5426e),
                  // Color(0xFF672b73),
                  Color(0xFF672b73),
                  Color(0xFF672b73),
                ]),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, Login.id),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                FadeAnimation(
                    0.1,
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 3,
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/images/54f9cc1d-f00d-4e02-a11d-413ad7e6cae8_200x200.png'),
                      )),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                FadeAnimation(
                    1.8,
                    Container(
                      child: Text(
                        'Applications',
                        style: TextStyle(
                            color: Color(0xFF2ec9f9),
                            // color: Color(0xFF74f9ff),
                            fontFamily: 'Arial',
                            fontSize: 28,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: 8,
                ),
                FadeAnimation(
                    1.8,
                    Container(
                      child: Text(
                        'Is your way',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arial',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          )),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                0.1,
                // 0.3,
                0.6,
                1.0
              ],
                  colors: [
                Color(0xFF58bdf2),
                // Color(0xFF8f5cf5),
                Color(0xFF8f5cf5),
                Color(0xFF8f5cf5),
              ])),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, Login.id),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                FadeAnimation(
                    0.1,
                    Container(
                      height: MediaQuery.of(context).size.height / 2.8,
                      width: MediaQuery.of(context).size.width / 0.8,
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/bisaklat.png'),
                      )),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                FadeAnimation(
                    1.8,
                    Container(
                      child: Text(
                        'Enjoy the moment',
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Color(0xFF74f9ff),
                            fontFamily: 'Arial',
                            fontSize: 28,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                FadeAnimation(
                    1.8,
                    Container(
                      child: Text(
                        'We will find you the best locations \n in a short time ',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Arial',
                          fontSize: 19,
                        ),
                      ),
                    )),
              ],
            ),
          )),
      // HADA 3
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.1,
              // 0.3,
              0.6,
              1.0
            ],
                colors: [
              Color(0xFF39ee7b),
              Color(0xFF129a8e),
              Color(0xFF129a8e),
            ])),
        // child: Padding(
        //   padding: EdgeInsets.symmetric(vertical: 40),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        //         alignment: Alignment.centerRight,
        //         child: FlatButton(
        //           onPressed: () =>
        //               Navigator.pushReplacementNamed(context, Login.id),
        //           child: Text(
        //             'Skip',
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         height: MediaQuery.of(context).size.height / 4,
        //       ),
        //       FadeAnimation(
        //           0.1,
        //           Container(
        //             // height: MediaQuery.of(context).size.height/6,
        //             // width: MediaQuery.of(context).size.width/3,
        //             // color: Colors.white,
        //             child: Text(
        //               'START BLOGINGG TODAY !',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           )),
        //       SizedBox(
        //         height: MediaQuery.of(context).size.height / 15,
        //       ),
        //       FadeAnimation(
        //           1.8,
        //           Container(
        //               height: MediaQuery.of(context).size.height / 11,
        //               width: MediaQuery.of(context).size.width / 1.3,
        //               decoration: BoxDecoration(
        //                   color: Colors.grey[850],
        //                   borderRadius: BorderRadius.all(Radius.circular(50)),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.grey[900],
        //                       offset: Offset(5.0, 5.0),
        //                       blurRadius: 15.0,
        //                       spreadRadius: 1.0,
        //                     ),
        //                     BoxShadow(
        //                       color: Colors.grey[800],
        //                       offset: Offset(-5.0, -5.0),
        //                       blurRadius: 15.0,
        //                       spreadRadius: 1.0,
        //                     ),
        //                   ]),
        //               child: Center(
        //                   child: FlatButton(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: 100, vertical: 12),
        //                 onPressed: () =>
        //                     Navigator.pushReplacementNamed(context, Login.id),
        //                 child: Text(
        //                   'Login',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     letterSpacing: 2,
        //                     fontFamily: 'calibri',
        //                     fontSize: 22,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               )))),
        //       SizedBox(
        //         height: MediaQuery.of(context).size.height / 22,
        //       ),
        //       FadeAnimation(
        //           1.8,
        //           Container(
        //               height: MediaQuery.of(context).size.height / 11,
        //               width: MediaQuery.of(context).size.width / 1.3,
        //               decoration: BoxDecoration(
        //                   color: Colors.grey[850],
        //                   borderRadius: BorderRadius.all(Radius.circular(50)),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.grey[900],
        //                       offset: Offset(5.0, 5.0),
        //                       blurRadius: 15.0,
        //                       spreadRadius: 1.0,
        //                     ),
        //                     BoxShadow(
        //                       color: Colors.grey[800],
        //                       offset: Offset(-5.0, -5.0),
        //                       blurRadius: 15.0,
        //                       spreadRadius: 1.0,
        //                     ),
        //                   ]),
        //               child: Center(
        //                   child: FlatButton(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: 70, vertical: 12),
        //                 onPressed: () => Navigator.pushReplacementNamed(
        //                     context, Signup.id),
        //                 child: Text(
        //                   'Creat New Account !',
        //                   style: TextStyle(
        //                       color: Color(0xFF74f9ff),
        //                       fontSize:
        //                           MediaQuery.of(context).size.width / 26,
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               )))),
        //     ],
        //   ),
        // )
      )
    ];
    // return Scaffold(
    //   body: AnnotatedRegion<SystemUiOverlayStyle>(
    //     value: SystemUiOverlayStyle.light,
    //     child:Container(
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           fit: BoxFit.cover,
    //           image: AssetImage('assets/images/qsdfg.png'),

    //           // fit: BoxFit.cover
    //         ),

    //       ),
    //       child: Container(
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             begin: Alignment.bottomCenter,
    //               end: Alignment.topCenter,
    //               // stops: [0.1,0.3,0.6,1.9],
    //             colors: [
    //                 Colors.black.withOpacity(1),
    //                 Colors.black.withOpacity(.9),
    //                 Colors.black.withOpacity(.8),
    //                 Colors.black.withOpacity(.7),
    //                 Colors.black.withOpacity(.69),
    //                 Colors.black.withOpacity(.59),
    //                 Colors.black.withOpacity(.49),
    //                 Colors.black.withOpacity(.39),
    //                 Colors.black.withOpacity(.4),
    //                 Colors.black.withOpacity(.05),
    //               ]
    //           )
    //         ),
    //         child: Padding(
    //         padding: EdgeInsets.symmetric(vertical:60),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             FadeAnimation(0.2,Container(
    //               alignment: Alignment.centerRight,
    //               child: FlatButton(
    //                 onPressed: () => Navigator.pushNamed(context,Login.id),
    //                 child: Text(
    //                   'Skip',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 18.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                 ),
    //               ),
    //             )),
    //             FadeAnimation(0.3,Container(
    //               padding: EdgeInsets.symmetric(vertical: 150.0),
    //               height: MediaQuery.of(context).size.height - 300,
    //               child: PageView(
    //                 physics: ClampingScrollPhysics(),
    //                 controller: _pagecontroller,
    //                 onPageChanged: (int page){
    //                   setState(() {
    //                     _currentPage = page;
    //                   });
    //                 },
    //                 children: <Widget>[
    //                   Padding(
    //                     padding:EdgeInsets.symmetric(horizontal: 48),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: <Widget>[
    //                         Text(
    //                           'Enjoy The Word ',
    //                           textScaleFactor: 1,
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 43,
    //                               fontWeight: FontWeight.bold
    //                             ),
    //                         ),
    //                         SizedBox(height: 10,),
    //                         Text(
    //                           'Well help you to find the best \n experience & adventures',
    //                           textScaleFactor: 1,
    //                             style: TextStyle(
    //                               color: Colors.white70,
    //                               fontSize: 22,
    //                               fontWeight: FontWeight.bold
    //                             ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding:EdgeInsets.symmetric(horizontal: 48),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: <Widget>[
    //                         Text(
    //                           'Enjoy the moment',
    //                           textScaleFactor: 1,
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 36,
    //                               fontWeight: FontWeight.bold
    //                             ),
    //                         ),
    //                         SizedBox(height: 10,),
    //                         Text(
    //                           'We will find you the best locations \n in a short time',
    //                           textScaleFactor: 1,
    //                             style: TextStyle(
    //                               color: Colors.white70,
    //                               fontSize: 18,
    //                               fontWeight: FontWeight.bold
    //                             ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(30),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: <Widget>[
    //                         Container(
    //                           child: Center(
    //                             child: Text(
    //                               'START BLOGINGG TODAY !',
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 20,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height:20),
    //                         Container(
    //                           height: 55,
    //                           width: MediaQuery.of(context).size.width/1.1,
    //                           decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.circular(30),
    //                           ),
    //                           child:Center(
    //                             child:FlatButton(
    //                               padding: EdgeInsets.symmetric(horizontal: 100,vertical: 12),
    //                               onPressed: () => Navigator.pushReplacementNamed(context,Login.id),
    //                               child: Text(
    //                                 'Login',
    //                                 style: TextStyle(
    //                                   fontSize: 20,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               ),
    //                             )
    //                           )
    //                         ),
    //                         SizedBox(height: 30,),
    //                         Container(
    //                           height: 55,
    //                           width: MediaQuery.of(context).size.width/1.1,
    //                           decoration: BoxDecoration(
    //                       border: Border.all(color:Colors.white),
    //                       // color: Color.fromRGBO(6, 52, 95, 2),
    //                       borderRadius: BorderRadius.circular(50),

    //                       // boxShadow: [BoxShadow(
    //                       //   color: Color.fromRGBO(2, 78, 95, .2),
    //                       //   blurRadius: 25,
    //                       //   offset: Offset(0,35)
    //                       // )]
    //                     ),
    //                           child:Center(
    //                             child:FlatButton(
    //                               padding: EdgeInsets.symmetric(horizontal: 70,vertical: 12),
    //                               onPressed: () => Navigator.pushReplacementNamed(context,Signup.id),
    //                               child: Text(
    //                                 'Login with google',
    //                                  style: TextStyle(
    //                                    color: Colors.white,
    //                                    fontSize: 20,
    //                                    fontWeight: FontWeight.bold
    //                                  ),
    //                               ),
    //                             )
    //                           )
    //                         ),
    //                       ],
    //                     ),
    //                   ),

    //                 ],
    //               ),
    //             ),
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: _buildPageIndicator(),
    //               ),
    //               _currentPage != _numpage -1
    //               ?Expanded(
    //                 child: Align(
    //                   alignment: FractionalOffset.bottomRight,
    //                   child: FlatButton(
    //                     onPressed: () {
    //                       _pagecontroller.nextPage(
    //                         duration: Duration(milliseconds: 500),
    //                         curve: Curves.ease,
    //                       );
    //                     },
    //                     child:FadeAnimation(0.3,Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: <Widget>[
    //                         Text(
    //                           'Next',
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 20.0,
    //                             ),
    //                         ),
    //                         SizedBox(width: 10.0,),
    //                         Icon(
    //                           Icons.arrow_forward_ios,
    //                           color: Colors.white,
    //                           size: 27.0,
    //                         )
    //                       ],
    //                     )),
    //                   ),
    //                 ),
    //               )
    //             :Text('')
    //           ],
    //         ),
    //       ),
    //       ),
    //     ),
    //   ),
    // );

// MANA YABDA DISGNE JDID

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          enableLoop: true,
          fullTransitionValue: 500,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.75,
          slideIconWidget: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
