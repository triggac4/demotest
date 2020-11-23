import 'package:flutter/material.dart';

class DisplayScheduleDetail extends StatelessWidget {
  DisplayScheduleDetail(
      {@required this.description,
      @required this.title,
      @required this.color,
      @required this.screenHeight})
      : assert(description != null),
        assert(title != null);
  final double screenHeight;
  final String title;
  final String description;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (screenHeight / 16) + 40,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: (screenHeight / 16) + 20,
            ),
            Text(
              description,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
