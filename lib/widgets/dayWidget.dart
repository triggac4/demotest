import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

int a = 1;
int? b = 2;

class IsDetailed extends StatelessWidget {
  IsDetailed(this.date, this.color, this.hasSchedule);

  late final DateTime? date;
  late final Color? color;
  late final bool hasSchedule;

  bool isTodaysDate() {
    if (date == null) {
      return false;
    }
    DateTime? now = DateTime.now();
    return date?.day == now.day &&
        date?.month == now.month &&
        date?.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    final bool today = isTodaysDate();
    final allSchedule = ScheduledDateProvider.of(context);
    final provider = StateNotifierProvider((ref) {
      return allSchedule;
    });

    return Consumer(
      builder: (_, watch, child) {
        var datee = watch(provider.state);
        bool isEqual = (datee.year == date?.year) &&
            (datee.month == date?.month) &&
            (datee.day == date?.day);
        Color borderColor;
        if (today) {
          borderColor = isEqual ? Colors.white : Colors.black;
        } else {
          borderColor = isEqual ? Colors.black : Colors.white;
        }
        return Container(
            constraints: BoxConstraints(minHeight: 35, minWidth: 35),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date == null
                      ? ''
                      : DateFormat('dd').format(date ?? DateTime.now()),
                  style: TextStyle(color: today ? Colors.white : null,),
                ),
                if (hasSchedule)
                  SizedBox(
                    height: 3,
                  ),
                if (hasSchedule)
                  Container(
                    height: 5,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color,
                    ),
                  )
              ],
            ));
      },
    );
  }
}

class DateWidget extends StatelessWidget {
  DateWidget(
      {required this.color,
      required this.date,
      required this.dateWidget,
      this.shadow,
      this.isDetailed = false});

  late final List<BoxShadow>? shadow;
  late final Color? color;
  late final Widget dateWidget;
  late final bool isDetailed;
  late final DateTime? date;

  bool isTodaysDate() {
    if (date == null) {
      return false;
    } else {
      DateTime? now = DateTime.now();
      return date?.day == now.day &&
          date?.month == now.month &&
          date?.year == now.year;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool today = isTodaysDate();
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
            color: today
                ? Colors.black
                : isDetailed
                    ? null
                    : color,
            boxShadow: today
                ? [
                    BoxShadow(
                        color: Colors.blueGrey,
                        offset: Offset(1, 1),
                        blurRadius: 3)
                  ]
                : shadow),
        child: isDetailed
            ? IsDetailed(date, color, date != null)
            : Text(
                date?.day.toString() ?? '',
                style: TextStyle(
                    color: today ? Colors.white : null),
              ),
      ),
    );
  }
}

class MonthDayWidget extends DateWidget {
  MonthDayWidget({@required DateTime? date})
      : super(
          dateWidget: Text(date == null ? '' : date.day.toString(), style:
                  TextStyle( color: Colors.white)),
          color: Colors.blueAccent[100],
          date: date,
          shadow: [
            BoxShadow(
                color: Colors.blueGrey, offset: Offset(1, 1), blurRadius: 3)
          ],
        );
}

class MonthDetailDayWidget extends DateWidget {
  MonthDetailDayWidget(
      {required DateTime? date,
      required Color? color,
      required bool hasSchedule})
      : super(
            dateWidget: IsDetailed(date, color, hasSchedule),
            color: color,
            shadow: null,
            date: date,
            isDetailed: true);
}
