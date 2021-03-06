import 'package:flutter/material.dart';
class WeekdayWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool isSun;
  const WeekdayWidget({required this.height,required this.width,required this.isSun});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 10),
      child: Container(
        height:(height-(height/25)),
        width: width,
        alignment: Alignment.topLeft,
        constraints: BoxConstraints(minHeight: 0,minWidth: 0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:isSun?Colors.red: Colors.black,
              offset: Offset(2,2),
              blurRadius: 2
            )
          ],
          color: Colors.blueAccent[200],
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20))
        ),
      ),
    );
  }
}