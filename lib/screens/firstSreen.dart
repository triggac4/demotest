import 'package:demotest/screens/homeScreen.dart';
import 'package:demotest/widgets/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      curve: Curves.bounceInOut,
      duration: 3000,
      splash:  SizedBox(
        height: 1000,
         child: Image.asset("images/appstore.jpg",fit: BoxFit.fill ,)),
      nextScreen: Calender(),
      backgroundColor: Theme.of(context).primaryColor,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
    );

  }
}
