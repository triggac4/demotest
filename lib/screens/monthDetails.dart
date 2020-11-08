import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/widgets/addSchedule.dart';
import 'package:demotest/widgets/littleSheduleWidget.dart';
import 'package:demotest/widgets/monthWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

class MonthDetails extends StatefulWidget {
  MonthDetails(this.month);
  final Month month;
  static const routeName = 'monthDetails';

  @override
  _MonthDetailsState createState() => _MonthDetailsState();
}

class _MonthDetailsState extends State<MonthDetails> {
  AllScheduledDate allschedule = AllScheduledDate(DateTime.now());
  Future<void> showButtomSheetz(DateTime day, BuildContext ctx) {
    return showBottomSheet(
        context: ctx,
        builder: (ctx) {
          return AddSchedule(day, allschedule);
        }).closed.then((value) => setState(() {}));
  }

  Future<void> removeScheduledDate(ScheduledDate schedule) async {
    await allschedule.removeSchedule(schedule).then((value) => setState(() {}));
  }

  var datee = DateTime.now();
  @override
  Widget build(BuildContext context) {
    allschedule = ScheduledDateProvider.of(context);
    var dayprovider = StateNotifierProvider((ref) {
      return allschedule;
    });
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MonthDetailWidget(
          chosenDates: allschedule,
          month: widget.month,
          function: showButtomSheetz,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text('Schedule for the Month',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Consumer(
          builder: (cxt, watch, child) {
            var dateee = watch(dayprovider.state);
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                allschedule.forThatDay(dateee).isEmpty
                    ? Text(
                        "no schedule for ${DateFormat.MMMMd().format(dateee)}")
                    : Text("Schedule for " +
                        DateFormat.MMMMd()
                            .format(allschedule.forThatDay(dateee)[0].date)),
                for (var index = 0;
                    index < allschedule.forThatDay(dateee).length;
                    index++)
                  allschedule.forThatDay(dateee) == []
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: LittleSchedule(
                              allschedule.forThatDay(dateee)[index],
                              removeScheduledDate))
              ],
            );
          },
        ))
      ]),
    );
  }
}
