import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/monthSceenResponsive.dart';
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
  bool bottomSheetOpen = false;
  Future<void> showButtomSheetz(DateTime day, BuildContext context) {
    setState(() {
      bottomSheetOpen = true;
    });
    return showBottomSheet(
        context: context,
        builder: (context) {
          return AddSchedule(day: day, chosenDate: allschedule);
        }).closed.then((value) => setState(() {
          bottomSheetOpen = false;
        }));
  }

  editScheduleDate(ScheduledDate scheduledDate, BuildContext context) {
    setState(() {
      bottomSheetOpen = true;
    });
    var schedule = ScheduledDateProvider.of(context);
    showBottomSheet(
        context: context,
        builder: (ctx) {
          return AddSchedule(
            chosenDate: schedule,
            scheduledDate: scheduledDate,
          );
        }).closed.then((value) => setState(() {
          bottomSheetOpen = false;
        }));
  }

  Future<void> removeScheduledDate(ScheduledDate schedule) async {
    await allschedule.removeSchedule(schedule).then((value) => setState(() {}));
  }

  var datee = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isPortrait = width <= 600;

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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: MonthDetailsResponse(
            listOfWidget: [
              Container(
                width: isPortrait ? null : width / 2,
                child: MonthDetailWidget(
                  bottomOpen: bottomSheetOpen,
                  chosenDates: allschedule,
                  month: widget.month,
                  function: showButtomSheetz,
                ),
              ),
              SizedBox(
                height: isPortrait ? 10 : null,
                width: isPortrait ? null : 10,
              ),
              Expanded(child: Consumer(
                builder: (cxt, watch, child) {
                  var dateee = watch(dayprovider.state);
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text('Schedule for the Month',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        allschedule.forThatDay(dateee).isEmpty
                            ? Text(
                                "no schedule for ${DateFormat.MMMMd().format(dateee)}")
                            : Text("Schedule for " +
                                DateFormat.MMMMd().format(
                                    allschedule.forThatDay(dateee)[0].date)),
                        SizedBox(
                          height: 10,
                        ),
                        if (allschedule.forThatDay(dateee).isEmpty)
                          Container(
                            child: Image.asset(
                                "images/no-schedule-no-schedule-png-194_181.png"),
                          ),
                        for (var index = 0;
                            index < allschedule.forThatDay(dateee).length;
                            index++)
                          allschedule.forThatDay(dateee) == []
                              ? SizedBox()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: LittleSchedule(
                                      editScheduleDate,
                                      allschedule.forThatDay(dateee)[index],
                                      removeScheduledDate))
                      ],
                    ),
                  );
                },
              ))
            ],
            width: width,
          ),
        ),
      ),
    );
  }
}
