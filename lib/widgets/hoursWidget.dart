import 'package:flutter/material.dart';
class HoursWidget extends StatelessWidget {
 final double height;
 final double width;
  const HoursWidget({Key key,this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: width,
    );
  }
}
