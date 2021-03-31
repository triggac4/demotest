import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ScheduleDetailTitleDescriptionWidget extends StatelessWidget {
  const ScheduleDetailTitleDescriptionWidget({required this.text,required this.title,required this.width});
  final String text;
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            style:TextStyle(
                color: Colors.redAccent,
                fontSize: 20
            ),
        ),
  SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Container(
              width:width-50,
              child: Text(text,
              ),
            ),
          ],
        ),
        Divider(
          color:Theme.of(context).primaryColor,
          thickness: 1,
        ),
      ],
    );
  }
}
