import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/scheduleDetailTitleDescriptionWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisplayScheduleDetail extends StatelessWidget {
  DisplayScheduleDetail(
      {
        @required this.scheduledDate,
        @required this.screenHeight, this.screenWidth,
      })
      : assert(scheduledDate != null);
  final double screenHeight;
  final ScheduledDate scheduledDate;
  final screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:screenHeight ,
            ),
            ScheduleDetailTitleDescriptionWidget(title: 'Title',width: screenWidth,text: scheduledDate.title,),
            ScheduleDetailTitleDescriptionWidget(title: 'Date',width: screenWidth,text: DateFormat('${scheduledDate.date.day} MMMM yyyy').format(scheduledDate.date)),
            ScheduleDetailTitleDescriptionWidget(title:'Time',width: screenWidth,text: DateFormat('hh:mm a').format(scheduledDate.date)),
            ScheduleDetailTitleDescriptionWidget(title: 'Description',width: screenWidth,text: scheduledDate.description,),
          ],
        ),
      );
  }
}
