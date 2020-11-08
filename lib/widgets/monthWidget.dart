import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/dayWidget.dart';
import 'package:demotest/models/monthModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

class MnthWidget extends StatefulWidget {
  MnthWidget({this.month, this.chosenDates, this.isDetail, this.function});
  final Month month;
  final AllScheduledDate chosenDates;
  final bool isDetail;
  final Function function;
  @override
  _MnthWidgetState createState() => _MnthWidgetState();
}

class _MnthWidgetState extends State<MnthWidget> {
  bool bottomSheetOpen = false;
  List<DateTime> monday = [];

  List<DateTime> tuesday = [];

  List<DateTime> wednesday = [];

  List<DateTime> thursday = [];

  List<DateTime> friday = [];

  List<DateTime> saturday = [];

  List<DateTime> sunday = [];

  var dazz = StateNotifierProvider<AllScheduledDate>((ref) {
    return AllScheduledDate(DateTime.now());
  });
  Column oneColumn(String dayz, List<DateTime> weekday) {
    List<InkWell> daywidgets = [];
    for (DateTime day in weekday) {
      var index =
          widget.isDetail ? widget.chosenDates.firstScheduleOfTheDay(day) : -1;
      daywidgets.add(InkWell(
        onTap: widget.isDetail
            ? () {
                if (bottomSheetOpen) {
                  Navigator.of(context).pop();
                  bottomSheetOpen = false;
                }
                // ignore: invalid_use_of_protected_member
                context.read(dazz).state = widget.chosenDates.selectedDay(day);
                FocusScope.of(context).unfocus();
              }
            : null,
        onDoubleTap: widget.isDetail
            ? () async {
                if (bottomSheetOpen) {
                  Navigator.of(context).pop();
                }
                // ignore: invalid_use_of_protected_member
                context.read(dazz).state = widget.chosenDates.selectedDay(day);
                bottomSheetOpen = true;
                widget.function(day, context).then((_) {
                  bottomSheetOpen = false;
                });
                index = widget.chosenDates.firstScheduleOfTheDay(day);
              }
            : null,
        child: widget.isDetail
            ? MonthDetailDayWidget(
                date: day,
                color: index < 0 ? null : widget.chosenDates.dates[index].color,
                isboxShadow: index >= 0 ? true : false)
            : MonthDayWidget(
                date: DateFormat('dd').format(day),
              ),
      ));
    }

    bool isSun = dayz.substring(0, 3) == 'Sun';
    return Column(children: [
      Text(
        dayz.substring(0, 3),
        style: TextStyle(color: isSun ? Colors.red : Colors.black),
      ),
      weekday[0].day > saturday[0].day
          ? DateWidget(date: Text(''))
          : SizedBox(height: 0),
      ...daywidgets,
      weekday[weekday.length - 1].day > saturday[saturday.length - 1].day
          ? SizedBox()
          : DateWidget(date: Text('')),
    ]);
  }

  List<Column> weekdays = [];

  initializeColumn() {
    monday = [];
    tuesday = [];
    wednesday = [];
    thursday = [];
    friday = [];
    saturday = [];
    sunday = [];

    for (DateTime i in widget.month.days) {
      switch (DateFormat('EEEE').format(i)) {
        case 'Sunday':
          sunday.add(i);
          break;
        case 'Monday':
          monday.add(i);
          break;
        case 'Tuesday':
          tuesday.add(i);
          break;
        case 'Wednesday':
          wednesday.add(i);
          break;
        case 'Thursday':
          thursday.add(i);
          break;
        case 'Friday':
          friday.add(i);
          break;
        case 'Saturday':
          saturday.add(i);
          break;
      }
    }

    weekdays = [
      oneColumn('Sunday', sunday),
      oneColumn('Monday', monday),
      oneColumn('Tuesday', tuesday),
      oneColumn('Wednesday', wednesday),
      oneColumn('Thursday', thursday),
      oneColumn('Friday', friday),
      oneColumn('Saturday', saturday)
    ];
  }

  @override
  Widget build(BuildContext context) {
    initializeColumn();
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      Container(
        child: Text(widget.month.id, style: TextStyle(fontSize: 40)),
      ),
      Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        //color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdays.map((e) => e).toList(),
        ),
      ),
    ]);
  }
}

class MonthDetailWidget extends MnthWidget {
  MonthDetailWidget(
      {AllScheduledDate chosenDates, Month month, Function function})
      : super(
          chosenDates: chosenDates,
          isDetail: true,
          month: month,
          function: function,
        );
}

class MonthHomeWidget extends MnthWidget {
  MonthHomeWidget({Month month}) : super(isDetail: false, month: month);
}
