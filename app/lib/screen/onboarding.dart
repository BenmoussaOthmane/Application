import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


class Onboarding extends StatefulWidget {
  static final String id = 'onboarding';
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final int _numpage = 3;
  final PageController _pagecontroller = PageController(initialPage: 0);
  int _currentPage = 0;

  List <Widget> _buildPageIndicator(){
    List<Widget> list = [];
    for(int i = 0; i < _numpage ; i++){
      list.add( i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
  Widget _indicator( bool isActive ){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color.fromRGBO(7, 206, 250,100) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/femme-cuisine-du-bois-feu-equipements-braai-par-nuit-tente-chaises-au-premier-plan-aventures-dans-parcs-nationaux-africains-image-tonique_107467-853.jpg'),
              
              // fit: BoxFit.cover
            ),

          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // stops: [0.1,0.3,0.6,1.9],
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(.5),
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.1),
                    Colors.black.withOpacity(.05),
                    Colors.black.withOpacity(.025),
                  ]
              )
            ),
            child: Padding(
            padding: EdgeInsets.symmetric(vertical:60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(0.2,Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.pushNamed(context,Login.id),
                    child: Text(
                      'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),
                    ),
                  ),
                )),
                FadeAnimation(0.3,Container(
                  padding: EdgeInsets.symmetric(vertical: 150.0),
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pagecontroller,
                    onPageChanged: (int page){
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Enjoy The Word ',
                              textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 43,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Well help you to find the best \n experience & adventures',
                              textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Enjoy the moment',
                              textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'We will find you the best locations \n in a short time',
                              textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Text(
                                  'START BLOGINGG TODAY !',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Georgia',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              height: 55,
                              width: 500,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child:Center(
                                child:FlatButton(
                                  padding: EdgeInsets.symmetric(horizontal: 100,vertical: 12),
                                  onPressed: () => Navigator.pushReplacementNamed(context,Login.id),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              )
                            ),
                            SizedBox(height: 30,),
                            Container(
                              height: 55,
                              width: 500,
                              decoration: BoxDecoration(
                          border: Border.all(color:Colors.white),
                          // color: Color.fromRGBO(6, 52, 95, 2),
                          borderRadius: BorderRadius.circular(50),

                          // boxShadow: [BoxShadow(
                          //   color: Color.fromRGBO(2, 78, 95, .2),
                          //   blurRadius: 25,
                          //   offset: Offset(0,35)
                          // )]
                        ),
                              child:Center(
                                child:FlatButton(
                                  padding: EdgeInsets.symmetric(horizontal: 70,vertical: 12),
                                  onPressed: () => Navigator.pushReplacementNamed(context,Signup.id),
                                  child: Text(
                                    'Login with google',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold
                                     ),
                                  ),
                                )
                              )
                            ),
                          ],
                        ),
                      ),
                      
                      
                    ],
                  ),
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                  ),
                  _currentPage != _numpage -1 
                  ?Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pagecontroller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child:FadeAnimation(0.3,Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ), 
                            ),
                            SizedBox(width: 10.0,),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 27.0,
                            )
                          ],
                        )),
                      ),
                    ),
                  )
                :Text('')
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}
