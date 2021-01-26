import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:flutter/material.dart';
class MonthScheduleList extends StatelessWidget {
  const MonthScheduleList({Key key, this.month}) : super(key: key);
  final Month month;
  @override
  Widget build(BuildContext context) {
    AllScheduledDate allScheduled= ScheduledDateProvider.of(context);
    final allMonthSchedules=allScheduled.forThatMonth(month);
    return Column(
      children:allMonthSchedules.map((e) => Text(e.date.toString())).toList() ,
    );
  }
}
