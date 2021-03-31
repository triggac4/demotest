import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/littleSheduleWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllSchedulesWidget extends StatelessWidget {
  const AllSchedulesWidget(
      {required this.closedButtomBar,
      required this.dateee,
      required this.allschedule,
      required this.editScheduleDate,
      required this.addSchedule,
      required this.removeScheduledDate});

  final void Function() addSchedule;
  final DateTime dateee;
  final Function closedButtomBar;
  final AllScheduledDate allschedule;
  final void Function(ScheduledDate scheduledDate, BuildContext context)
      editScheduleDate;
  final Function removeScheduledDate;

  @override
  Widget build(BuildContext context) {
    final forThatDay = allschedule.forThatDay(dateee);
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              forThatDay.isEmpty
                  ? Text("no schedule for ${DateFormat.MMMMd().format(dateee)}",
                      style: TextStyle(fontWeight: FontWeight.bold))
                  : Text(
                      "Schedule for " +
                          DateFormat.MMMMd().format(forThatDay[0].date),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              SizedBox(
                height: 10,
              ),
              if (forThatDay.isEmpty)
                Container(
                  child: Image.asset(
                      "images/no-schedule-no-schedule-png-194_181.png"),
                ),
              for (var index = 0; index < forThatDay.length; index++)
                forThatDay == []
                    ? SizedBox()
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: LittleSchedule(
                            closedButtomBar,
                            editScheduleDate,
                            allschedule.forThatDay(dateee)[index],
                            removeScheduledDate)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width / 3,
            child: TextButton(
                onPressed: addSchedule,
                child: Text(
                  '+',
                  style: TextStyle(color: Colors.black, fontSize: 19),
                )))
      ],
    );
  }
}
