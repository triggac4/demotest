import 'package:flutter/material.dart';

class DisplayScheduleDetail extends StatelessWidget {
  DisplayScheduleDetail(
      {@required this.description, @required this.title, @required this.color})
      : assert(description != null),
        assert(title != null);
  final String title;
  final String description;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
