import 'dart:math';

import 'package:demotest/models/localNotification.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/screens/homeScreen.dart';
import 'package:demotest/screens/scaffoldButtomBar.dart';
import 'package:demotest/screens/scheduleDetails.dart';
import 'package:demotest/widgets/howLong.dart';
import 'package:flutter/material.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule({this.day, @required this.chosenDate, this.scheduledDate});

  final DateTime day;
  final AllScheduledDate chosenDate;
  final ScheduledDate scheduledDate;

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime scheduledDate;
  TimeOfDay time = TimeOfDay.now();
  LengthOfSchedule los = LengthOfSchedule(hour: 1, minutes: 0);
  final String monthly = 'monthly';
  final String yearly = 'yearly';
  final String once = 'once';
  List<String> choosePeriod = [];
  String period = '';

  initState() {
    super.initState();
    choosePeriod = [once, yearly, monthly];
    colorPosition = widget.scheduledDate?.positionInColor ?? colorPosition;
    titleController.text = widget.scheduledDate?.title ?? '';
    desController.text = widget.scheduledDate?.description ?? '';
    period = widget.scheduledDate?.period ?? once;
    time = TimeOfDay(
        hour: widget.scheduledDate?.date?.hour ?? TimeOfDay.now().hour,
        minute: widget.scheduledDate?.date?.minute ?? TimeOfDay.now().minute);
    los = LengthOfSchedule(
      hour: widget.scheduledDate?.dateEnd?.hour ?? 1,
      minutes: widget.scheduledDate?.dateEnd?.minutes ?? 0,
    );
  }


  pickTime(context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((newTime) {
      TimeOfDay newTi = newTime;
      if (newTi == null) {
        return;
      } else {
        setState(() {
          time = newTi;
        });
      }
    });
  }

  var hoursController = TextEditingController();
  var titleController = TextEditingController();
  var desController = TextEditingController();
  var error = '';

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    desController.dispose();
    hoursController.dispose();
  }

  Widget timeSelector() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FlatButton(
          color: Colors.orangeAccent,
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            pickTime(context);
          },
          child: Text('pick time'),
        ),
        SizedBox(width: 15),
        Text(time.format(context)),
      ],
    );
  }

  List<int> colorPostions =
      List.generate(ScheduledDate.colors.length, (index) => index);
  int colorPosition = Random().nextInt(ScheduledDate.colors.length);

  Future<void> _addOrEditSchedule() async {
    var forTitle = titleController.text.isEmpty;
    var forDes = desController.text.isEmpty || desController.text.length < 10;
    if (forTitle || forDes) {
      if (forTitle)
        error = "Your Title Input Is Empty";
      else
        error =
            "Your Description Field contains only ${desController.text.length} char";
      setState(() {});
      return;
    }
    if (widget.scheduledDate == null) {
      var date = DateTime(widget.day.year, widget.day.month, widget.day.day,
          time.hour, time.minute);

      await widget.chosenDate.addSchedule(date, los, titleController.text,
          desController.text, period, colorPosition);
    } else {
      var date = DateTime(
          widget.scheduledDate.date.year,
          widget.scheduledDate.date.month,
          widget.scheduledDate.date.day,
          time.hour,
          time.minute);
      await widget.chosenDate.updateSchedule(date, los, titleController.text,
          desController.text, period, colorPosition, widget.scheduledDate.id);
    }
    Navigator.of(context).pop();
  }

  changeHour(int hour) {
    setState(() {
      los = LengthOfSchedule.together(together: hour);
    });
  }

  Widget endDateWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton(
            color: Colors.orangeAccent,
            onPressed: () => showDialog(
                context: context,
                builder: (_) =>
                    HowLong(initialHowLong: los.together, changed: changeHour)),
            child: Text('hours')),
        SizedBox(width: 10),
        Text('${los.hour}hr ${los.minutes}min')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 340 + MediaQuery.of(context).viewInsets.bottom,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    border: OutlineInputBorder(),
                    hintText: "Schedule Title"),
                controller: titleController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                minLines: 2,
                maxLines: 10,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    border: OutlineInputBorder(),
                    hintText: "Description"),
                controller: desController,
              ),
            ),
            SizedBox(height: 10),
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                    items: choosePeriod.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                        onTap: () => setState(() {
                          period = e;
                        }),
                      );
                    }).toList(),
                    value: period,
                    onChanged: (_) {}),
                DropdownButton(
                    items: colorPostions.map((index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: ScheduledDate.colors[index],
                          ),
                        ),
                        onTap: () => setState(() {
                          colorPosition = index;
                        }),
                      );
                    }).toList(),
                    underline: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ScheduledDate.colors[colorPosition],
                      ),
                    ),
                    onChanged: (_) {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                timeSelector(),
                endDateWidget(),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                color: Colors.orangeAccent,
                width: double.infinity,
                child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Icon(Icons.add),
                    onPressed: _addOrEditSchedule),
              ),
            )
          ],
        ),
      ),
    );
  }
}
