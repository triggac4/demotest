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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text('Daily'),
                    ),
                    DropdownMenuItem(child: Text('Daily')),
                    DropdownMenuItem(child: Text('Daily'))
                  ],
                ),
                FlatButton(
                  color: Colors.orangeAccent,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    pickTime(context);
                  },
                  child: Text('pick time'),
                ),
                Text(time.format(context)),
              ],
            ),
            SizedBox(height: 10),
            Text(
              error,
              style: TextStyle(color: Colors.red),
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
                        date, titleController.text, desController.text);
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
