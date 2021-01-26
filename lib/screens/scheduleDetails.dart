import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/displayScheduleDetails.dart';
import 'package:demotest/widgets/scheduleDetailDateWidget.dart';
import 'package:flutter/material.dart';

class ScheduleDetail extends StatelessWidget {
  ScheduleDetail(this.scheduledDate);
  final ScheduledDate scheduledDate;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: DisplayScheduleDetail(
            scheduledDate: scheduledDate,
            screenWidth:screenWidth,
            screenHeight: screenHeight/30,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
