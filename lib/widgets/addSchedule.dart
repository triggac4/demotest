import 'package:demotest/models/scheduledDateModel.dart';
import 'package:flutter/material.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule(
    this.day,
    this.chosenDate,
  );
  final DateTime day;
  final AllScheduledDate chosenDate;

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime scheduledDate;
  TimeOfDay time = TimeOfDay.now();
  final String monthly = 'monthly';
  final String yearly = 'yearly';
  final String once = 'once';
  List<String> choosePeriod = [];
  String period = '';
  initState() {
    super.initState();
    choosePeriod = [once, yearly, monthly];
    period = once;
  }

  pickTime(context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((newTime) {
      setState(() {
        time = newTime;
      });
    });
  }

  var titleController = TextEditingController();
  var desController = TextEditingController();
  var error = '';
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    desController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).primaryColor,
        height: 340 + MediaQuery.of(context).viewInsets.bottom,
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
                minLines: 4,
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
                timeSelector(),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                color: Colors.orangeAccent,
                width: double.infinity,
                child: FlatButton(
                  child: Icon(Icons.add),
                  onPressed: () async {
                    var forTitle = titleController.text.isEmpty;
                    var forDes = desController.text.isEmpty ||
                        desController.text.length < 10;
                    if (forTitle || forDes) {
                      if (forTitle)
                        error = "Your Title Input Is Empty";
                      else
                        error =
                            "Your Description Field contains only ${desController.text.length} char";
                      setState(() {});
                      return;
                    }
                    var date = DateTime(widget.day.year, widget.day.month,
                        widget.day.day, time.hour, time.minute);
                    print(date);
                    await widget.chosenDate.addSchedule(
                        date, titleController.text, desController.text, period);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
