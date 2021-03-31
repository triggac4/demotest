import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/widgets/dayWidget.dart';
import 'package:demotest/models/monthModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MnthWidget extends StatefulWidget {
  MnthWidget(
      {required this.bottomSheetOpens,
      required this.month,
      required this.chosenDates,
      required this.isDetail,
      required this.function});

  final Month month;
  final AllScheduledDate? chosenDates;
  final bool isDetail;
  final Function? function;
  final bool bottomSheetOpens;

  @override
  _MnthWidgetState createState() => _MnthWidgetState();
}

class _MnthWidgetState extends State<MnthWidget> {
  initState() {
    super.initState();
    dazz = StateNotifierProvider<AllScheduledDate>((ref) {
      return allScheduledDate;
    });
  }

  bool get bottomSheetOpen {
    return widget.bottomSheetOpens;
  }

  bool once = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (once) {
      allScheduledDate = ScheduledDateProvider.of(context);
      once = false;
    }
  }

  late AllScheduledDate allScheduledDate;
  late StateNotifierProvider<AllScheduledDate> dazz;

  Column oneColumn(String dayz, List<DateTime> weekday) {
    List<InkWell> daywidgets = [];
    for (DateTime day in weekday) {
      int index = widget.chosenDates?.firstScheduleOfTheDay(day) ?? -1;
      daywidgets.add(InkWell(
        onTap: widget.isDetail
            ? () {
                if (bottomSheetOpen) {
                  Navigator.of(context).pop();
                }
                // ignore: invalid_use_of_protected_member
                 widget.chosenDates?.selectedDay(day);
                FocusScope.of(context).unfocus();
              }
            : null,
        onDoubleTap: widget.isDetail
            ? () async {
                if (bottomSheetOpen) {
                  Navigator.of(context).pop();
                }
                // ignore: invalid_use_of_protected_member
                 widget.chosenDates?.selectedDay(day);
                index = widget.chosenDates?.firstScheduleOfTheDay(day) ?? -1;
                print(day);
                widget.function!(day, context);
              }
            : null,
        child: widget.isDetail
            ? MonthDetailDayWidget(
                date: day,
                color:
                    index < 0 ? null : widget.chosenDates?.dates[index].color,
                hasSchedule: index >= 0 ? true : false)
            : MonthDayWidget(
                date: day,
              ),
      ));
    }

    bool isSun = dayz.substring(0, 3) == 'Sun';
    return Column(children: [
      Text(
        dayz.substring(0, 3),
        style: TextStyle(color: isSun ? Colors.red : Colors.black,fontWeight: FontWeight.bold),
      ),
      weekday[0].day > widget.month.dayAndDate['Saturday']![0].day
          ? MonthDetailDayWidget(date: null, color: null, hasSchedule: false)
          : SizedBox(height: 0),
      ...daywidgets,
      weekday[weekday.length - 1].day >
              widget
                  .month
                  .dayAndDate['Saturday']![
                      widget.month.dayAndDate['Saturday']!.length - 1]
                  .day
          ? SizedBox()
          : MonthDetailDayWidget(date: null, color: null, hasSchedule: false),
    ]);
  }

  List<Column> weekdays = [];

  initializeColumn() {
    weekdays = [
      oneColumn('Sunday', widget.month.dayAndDate['Sunday']!),
      oneColumn('Monday', widget.month.dayAndDate['Monday']!),
      oneColumn('Tuesday', widget.month.dayAndDate['Tuesday']!),
      oneColumn('Wednesday', widget.month.dayAndDate['Wednesday']!),
      oneColumn('Thursday', widget.month.dayAndDate['Thursday']!),
      oneColumn('Friday', widget.month.dayAndDate['Friday']!),
      oneColumn('Saturday', widget.month.dayAndDate['Saturday']!)
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
      {required AllScheduledDate? chosenDates,
      required Month month,
      required Function function,
      required bool bottomOpen})
      : super(
            chosenDates: chosenDates,
            isDetail: true,
            month: month,
            function: function,
            bottomSheetOpens: bottomOpen);
}

class MonthHomeWidget extends MnthWidget {
  MonthHomeWidget({required Month month})
      : super(
            isDetail: false,
            month: month,
            bottomSheetOpens: false,
            chosenDates: null,
            function: null);
}
