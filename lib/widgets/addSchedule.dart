import 'dart:math';

import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/widgets/howLong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule({required this.day, required this.chosenDate, this.scheduledDate});

  final DateTime day;
  final AllScheduledDate chosenDate;
  final ScheduledDate? scheduledDate;

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  late DateTime scheduledDate;
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
        hour: widget.scheduledDate?.date.hour ?? TimeOfDay.now().hour,
        minute: widget.scheduledDate?.date.minute ?? TimeOfDay.now().minute);
    los = LengthOfSchedule(
      hour: widget.scheduledDate?.dateEnd.hour ?? 1,
      minutes: widget.scheduledDate?.dateEnd.minutes ?? 0,
    );
  }

  pickTime(context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((newTime) {
      TimeOfDay? newTi = newTime;
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
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            padding: MaterialStateProperty.all(EdgeInsets.zero)
          ),
          onPressed: () {
            pickTime(context);
          },
          child: Text('pick time',style:TextStyle(color:Colors.black)),
        ),
        SizedBox(width: 15),
        Text(time.format(context)),
      ],
    );
  }

  List<int> colorPostions =
      List.generate(ScheduledDate.colors.length, (index) => index);
  int colorPosition = Random().nextInt(ScheduledDate.colors.length);
bool processing=false;
  Future<void> _addOrEditSchedule() async {
    setState(() {
      processing=true;
    });
    var forTitle = titleController.text.isEmpty;
    var forDes = desController.text.isEmpty || desController.text.length < 10;
    if (forTitle || forDes) {
      if (forTitle)
        error = "Your Title Input Is Empty";
      else
        error =
            "Your Description Field contains only ${desController.text.length} char";
        setState(() {
          processing=false;
      });
      return;
    }
    if (widget.scheduledDate == null ) {
      var date = DateTime(widget.day.year, widget.day.month,
          widget.day.day, time.hour, time.minute);
      try {
        await widget.chosenDate.addSchedule(date, los, titleController.text,
            desController.text, period, colorPosition);
      } on PlatformException catch (e) {
        setState(() {
          processing=false;
        });
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.removeCurrentSnackBar();
        scaffold.showSnackBar(SnackBar(
          content: Text(e.message!),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
              label: 'Ok', onPressed: () => scaffold.removeCurrentSnackBar()),
        ));
      }
    } else {
      var date = DateTime(
          widget.scheduledDate?.date.year??0,
          widget.scheduledDate?.date.month??0,
          widget.scheduledDate?.date.day??0,
          time.hour,
          time.minute);
      try {
        await widget.chosenDate.updateSchedule(
            date,
            los,
            titleController.text,
            desController.text,
            period,
            colorPosition,
            widget.scheduledDate?.id??'rand');
      } on PlatformException catch (e) {
        setState(() {
          processing=false;
        });
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.removeCurrentSnackBar();
        scaffold.showSnackBar(SnackBar(
          content: Text(e.message!),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () => scaffold.removeCurrentSnackBar(),
          ),
        ));
      }
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
        TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.orangeAccent)),
            onPressed: () => showDialog(
                context: context,
                builder: (_) =>
                    HowLong(initialHowLong: los.together, changed: changeHour)),
            child: Text('hours',style:TextStyle(color:Colors.black))),
        SizedBox(width: 10),
        Text('${los.hour}hr ${los.minutes}min')
      ],
    );
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:5),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
          border: Border.all(color: Colors.black,style: BorderStyle.solid,width: 1)
        ),
        height: 340 + MediaQuery.of(context).viewInsets.bottom,
        child: Scrollbar(
          controller: scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:10,top: 10,right: 10),
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
                  padding: const EdgeInsets.only(left:10,top: 10,right: 10,bottom: 5),
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
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    color: Colors.orangeAccent,
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                        child: processing?Center(child:CircularProgressIndicator()): Icon(Icons.add,color: Colors.black,),
                        onPressed:processing?null: _addOrEditSchedule),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
