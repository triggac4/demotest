import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/displayScheduleDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDetail extends StatelessWidget {
  ScheduleDetail(this.scheduledDate);
  final ScheduledDate scheduledDate;
  Container dateDetails(
      double screenHeight, double screenWidth, BuildContext context) {
    int day = scheduledDate.date.day;
    return Container(
      height: screenHeight / 8,
      width: screenWidth / 1.5,
      decoration: BoxDecoration(
          color: scheduledDate.color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              DateFormat('EEEE').format(scheduledDate.date),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  DateFormat('$day MMMM ,yyyy').format(scheduledDate.date),
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 5),
                child: Text(
                  DateFormat('hh:mm a').format(scheduledDate.date),
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  height: screenHeight / 5,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Image.asset("images/calendar-pngrepo-com.png"),
                ),
                Positioned(
                    bottom: -screenHeight / 16,
                    child: dateDetails(screenHeight, screenWidth, context))
              ]),
          // SizedBox(
          //   height: (screenHeight / 16) + 5,
          // ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6),
            child: DisplayScheduleDetail(
              description: scheduledDate.description,
              title: scheduledDate.title,
              color: scheduledDate.color,
            ),
          ))
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
