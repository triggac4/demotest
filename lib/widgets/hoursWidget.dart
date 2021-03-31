import 'package:flutter/material.dart';
class HoursWidget extends StatelessWidget {
 final double height;
 final double width;
  HoursWidget({required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: width,
    );
  }
}
