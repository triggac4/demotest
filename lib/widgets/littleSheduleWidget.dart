import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/screens/scheduleDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LittleSchedule extends StatelessWidget {
  LittleSchedule(this.scheduledDate, this.removeSchedule);
  final Function removeSchedule;
  final ScheduledDate scheduledDate;
  openSchedulePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ScheduleDetail(scheduledDate);
    }));
  }

  build(BuildContext context) {
    return InkWell(
      onTap: () {
        openSchedulePage(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(1, 2),
                blurRadius: 2,
                color: scheduledDate.color,
              )
            ]),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      scheduledDate.title,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(DateFormat('hh:mm').format(scheduledDate.date),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45))
                  ],
                ),
                FlatButton(
                    onPressed: () => removeSchedule(scheduledDate),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ]),
        ),
      ),
    );
  }
}
