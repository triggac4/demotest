import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/littleSheduleWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllSchedulesWidget extends StatelessWidget {
  const AllSchedulesWidget(
      {Key key,
      this.dateee,
      this.allschedule,
      this.editScheduleDate,
      this.removeScheduledDate})
      : super(key: key);
  final DateTime dateee;
  final AllScheduledDate allschedule;
  final Function editScheduleDate;
  final Function removeScheduledDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('Schedule for the Month',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          allschedule.forThatDay(dateee).isEmpty
              ? Text("no schedule for ${DateFormat.MMMMd().format(dateee)}")
              : Text("Schedule for " +
                  DateFormat.MMMMd()
                      .format(allschedule.forThatDay(dateee)[0].date)),
          SizedBox(
            height: 10,
          ),
          if (allschedule.forThatDay(dateee).isEmpty)
            Container(
              child:
                  Image.asset("images/no-schedule-no-schedule-png-194_181.png"),
            ),
          for (var index = 0;
              index < allschedule.forThatDay(dateee).length;
              index++)
            allschedule.forThatDay(dateee) == []
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: LittleSchedule(
                        editScheduleDate,
                        allschedule.forThatDay(dateee)[index],
                        removeScheduledDate))
        ],
      ),
    );
  }
}
