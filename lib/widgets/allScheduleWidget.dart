import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/littleSheduleWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllSchedulesWidget extends StatelessWidget {
  const AllSchedulesWidget(
      {Key key,
        this.closedButtomBar,
      this.dateee,
      this.allschedule,
      this.editScheduleDate,
      this.removeScheduledDate})
      : super(key: key);
  final DateTime dateee;
  final Function closedButtomBar;
  final AllScheduledDate allschedule;
  final Function editScheduleDate;
  final Function removeScheduledDate;

  @override
  Widget build(BuildContext context) {
    final forThatDay=allschedule.forThatDay(dateee);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          forThatDay.isEmpty
              ? Text("no schedule for ${DateFormat.MMMMd().format(dateee)}",style:TextStyle(fontWeight: FontWeight.bold))
              : Text("Schedule for " +
                  DateFormat.MMMMd()
                      .format(forThatDay[0].date),style:TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 10,
          ),
          if (forThatDay.isEmpty)
            Container(
              child:
                  Image.asset("images/no-schedule-no-schedule-png-194_181.png"),
            ),
          for (var index = 0;
              index < forThatDay.length;
              index++)
            forThatDay == []
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: LittleSchedule(
                      closedButtomBar,
                        editScheduleDate,
                        allschedule.forThatDay(dateee)[index],
                        removeScheduledDate))
        ],
      ),
    );
  }
}
