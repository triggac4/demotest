import 'package:demotest/models/scheduledDateModel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class ScheduleDetailDate extends StatelessWidget {
  ScheduleDetailDate(
      {@required this.scheduledDate,
      @required this.screenHeight,
      @required this.screenWidth});
  final double screenHeight;
  final double screenWidth;
  final ScheduledDate scheduledDate;

  @override
  Widget build(BuildContext context) {
    int day = scheduledDate.date.day;

    return Container(
      height: screenHeight / 8,
      width: screenWidth / 1.5,
      constraints: BoxConstraints(minWidth:screenWidth / 1.5,minHeight: screenHeight / 8),
      decoration: BoxDecoration(
          color: scheduledDate.color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
               Text(
                DateFormat('EEEE').format(scheduledDate.date),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).primaryColorDark),

            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 7.0),
                  child: Text(
                    DateFormat('$day MMMM ,yyyy').format(scheduledDate.date),
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    DateFormat('hh:mm a').format(scheduledDate.date),
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
