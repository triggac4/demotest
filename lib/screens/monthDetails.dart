import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/monthSceenResponsive.dart';
import 'package:demotest/widgets/addSchedule.dart';
import 'package:demotest/widgets/allScheduleWidget.dart';
import 'package:demotest/widgets/monthWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

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
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    bool isPortrait = mediaQuery.orientation == Orientation.portrait;

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
          height: mediaQuery.size.height - 50,
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
                  return AllSchedulesWidget(
                    allschedule: allschedule,
                    dateee: dateee,
                    editScheduleDate: editScheduleDate,
                    removeScheduledDate: removeScheduledDate,
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
