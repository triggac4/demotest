import 'package:demotest/models/scheduledDateModel.dart';
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
      body: Column(
        children: [
          Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: [
                Container(
                  height: screenHeight / 5,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Positioned(
                    bottom: -screenHeight / 12,
                    child: Container(
                      height: screenHeight / 6,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(
                          color: scheduledDate.color,
                          borderRadius: BorderRadius.circular(50)),
                    ))
              ]),
          SizedBox(
            height: screenHeight / 12,
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
