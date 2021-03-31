import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/monthSceenResponsive.dart';
import 'package:demotest/widgets/addSchedule.dart';
import 'package:demotest/widgets/allScheduleWidget.dart';
import 'package:demotest/widgets/monthWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthDetails extends StatefulWidget {
  MonthDetails(this.month);
  late final Month month;
  static const routeName = 'monthDetails';

  @override
  _MonthDetailsState createState() => _MonthDetailsState();
}

class _MonthDetailsState extends State<MonthDetails> {
  AllScheduledDate allschedule = AllScheduledDate(DateTime.now());
  bool bottomSheetOpen = false;
  bool isDisposed=false;
  void dispose(){
    isDisposed=true;
    super.dispose();
  }

  PersistentBottomSheetController showButtomSheetz(DateTime day, BuildContext context) {
    setState(() {
      bottomSheetOpen = true;
    });
    final _controller= Scaffold.of(context).showBottomSheet(
        (context){
          return AddSchedule(day: day, chosenDate: allschedule);
        })..closed.then((value) =>isDisposed?null:bottomBarClosed());
    return _controller;
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
            day: DateTime.now(),
            chosenDate: schedule,
            scheduledDate: scheduledDate,
          );
        }).closed.then((value) =>isDisposed?null: bottomBarClosed());
  }

  Future<void> removeScheduledDate(ScheduledDate schedule) async {
    try {
      await allschedule.removeSchedule(schedule).then((value) =>
          setState(() {}));
    }on PlatformException catch(e){
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.removeCurrentSnackBar();
      scaffold.showSnackBar(SnackBar(
        content: Text(e.message!), duration: Duration(seconds: 2), action:SnackBarAction(
          label: 'Ok',
          onPressed: ()=>scaffold.removeCurrentSnackBar()),
      ));
    }
    }
 void bottomBarClosed(){
 setState(() {
   bottomSheetOpen = false;
 });
 }
  var datee = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    bool isPortrait = width<700;

    allschedule = ScheduledDateProvider.of(context);
    var dayProvider = StateNotifierProvider((ref) {
      return allschedule;
    });
    return  SizedBox(
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
            Consumer(
              builder: (cxt, watch, child) {
                var dateee = watch(dayProvider.state);
                return AllSchedulesWidget(
                  closedButtomBar:bottomBarClosed,
                  // ignore: invalid_use_of_protected_member
                  addSchedule: ()=>showButtomSheetz(allschedule.state, context),
                  allschedule: allschedule,
                  dateee: dateee,
                  editScheduleDate: editScheduleDate,
                  removeScheduledDate: removeScheduledDate,
                );
              },
            )
          ],
          width: width,
        ),
      );
  }
}
