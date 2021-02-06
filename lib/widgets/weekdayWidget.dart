import 'package:flutter/material.dart';
class WeekdayWidget extends StatelessWidget {
  final double height;
  final double width;
  const WeekdayWidget({Key key,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 3,vertical: 20),
      child: Container(
        height:(height-(height/25)),
        width: width,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2,-1),
              blurRadius: 2
            )
          ],
          color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20))
        ),
      ),
    );
  }
}