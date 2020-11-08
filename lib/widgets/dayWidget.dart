import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

class IsDetailed extends StatelessWidget {
  IsDetailed(this.date);
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final allSchedule = ScheduledDateProvider.of(context);
    final provider = StateNotifierProvider((ref) {
      return allSchedule;
    });

    return Consumer(
      builder: (_, watch, child) {
        var datee = watch(provider.state);
        bool isEqual = (datee.year == date.year) &&
            (datee.month == date.month) &&
            (datee.day == date.day);
        return isEqual
            ? Container(
                constraints: BoxConstraints(minHeight: 35, minWidth: 35),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                alignment: Alignment.center,
                child: Text(
                  DateFormat('dd').format(date),
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Text(DateFormat('dd').format(date));
      },
    );
  }
}

class DateWidget extends StatelessWidget {
  DateWidget({this.color, @required this.date, this.shadow});
  final List<BoxShadow> shadow;
  final Color color;
  final Widget date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
            minWidth: 40,
            minHeight: 40,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
              boxShadow: shadow),
          child: date),
    );
  }
}

class MonthDayWidget extends DateWidget {
  MonthDayWidget({@required String date})
      : assert(date != null),
        super(date: Text(date), color: Colors.blueAccent[100], shadow: [
          BoxShadow(color: Colors.blueGrey, offset: Offset(1, 1), blurRadius: 3)
        ]);
}

class MonthDetailDayWidget extends DateWidget {
  MonthDetailDayWidget({@required DateTime date, Color color, bool isboxShadow})
      : assert(date != null),
        super(
            date: IsDetailed(date),
            color: color,
            shadow: isboxShadow
                ? [
                    BoxShadow(
                        color: Colors.blueGrey,
                        offset: Offset(1, 1),
                        blurRadius: 3)
                  ]
                : null);
}
