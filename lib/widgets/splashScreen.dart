import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _sizeChange =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
  late Animation _animation = Tween<double>(begin: 0, end: 1)
      .animate(CurvedAnimation(parent: _sizeChange, curve: Curves.bounceInOut));
@override
  void initState() {
    _sizeChange.forward();
     super.initState();
  }

  @override
  void dispose() {
 _sizeChange.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, image) {
        return SizedBox(
          height:500.0*_animation.value,
          width: 300.0*_animation.value,
          child: Image.asset("images/appstore.jpg",fit: BoxFit.fill ,),
        );
      },

    );
  }
}
