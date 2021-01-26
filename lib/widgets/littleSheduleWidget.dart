import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/screens/scheduleDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LittleSchedule extends StatelessWidget {
  LittleSchedule(
      this.closedButtomBar,
    this.editScheduleDate,
    this.scheduledDate,
    this.removeSchedule,
  );
  final Function(ScheduledDate scheduledDate, BuildContext context)
      editScheduleDate;
  final Function closedButtomBar;
  final Function removeSchedule;
  final ScheduledDate scheduledDate;
  openSchedulePage(BuildContext context) {
    Navigator.of(context,rootNavigator: true).push(
      MaterialPageRoute(builder: (context) {
        return ScheduleDetail(scheduledDate);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor=Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        closedButtomBar();
        openSchedulePage(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color:
            Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(1, 5),
                blurRadius: 4,
                color:Colors.grey[700],
              )
            ]),
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                    ),
                    color:scheduledDate.color
                ),
                width: 20,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 100,maxHeight: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   SizedBox(width: 10,),
                    Text(
                      scheduledDate.title.length>30?'${scheduledDate.title.substring(0,26)}...':scheduledDate.title,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(DateFormat('hh:mm').format(scheduledDate.date),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45))
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        editScheduleDate(scheduledDate, context);
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.edit,
                        color:primaryColor,
                      )),
                  IconButton(
                      onPressed: () => removeSchedule(scheduledDate),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
                ],
              ),
        ),
      ),
    );
  }
}
