import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/widgets/weekdayWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthScheduleList extends StatelessWidget {
  MonthScheduleList({required this.month});

  late final Month month;

  Widget bars(
    String weekday,
    String abrivDay,
    double widthContainer,
    double maxHeight,
    double heightContainers,
    Map<String, int> sum,
  ) {
   var numb= (((((sum[weekday]! / sum['total']!)))/1)*100).toStringAsFixed(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 15,
          alignment: Alignment.bottomCenter,
          child: Text(
            abrivDay,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: abrivDay == 'Sun' ? Colors.red : Colors.black),
          ),
        ),
        WeekdayWidget(
          isSun: abrivDay == 'Sun',
          width: widthContainer,
          height: (maxHeight * ((sum[weekday]! / sum['total']!)))
          ),
        Container(
          height: 20,
          width: 50,
          child:Text('${numb}%')
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> sum = {
      'monday': 0,
      'tuesday': 0,
      'wednesday': 0,
      'thursday': 0,
      'friday': 0,
      'saturday': 0,
      'sunday': 0,
      'total': 0
    };
    AllScheduledDate allScheduled = ScheduledDateProvider.of(context);
    final allMonthSchedules = allScheduled.forThatMonth(month);
    List.generate(allMonthSchedules.length, (index) {
      ScheduledDate schedule = allMonthSchedules[index];
      sum['total'] = sum['total']! + schedule.dateEnd.together;
      int weekday = schedule.date.weekday;
      switch (weekday) {
        case 1:
          sum['monday'] = sum['monday']! + schedule.dateEnd.together;
          break;
        case 2:
          sum['tuesday'] = sum['tuesday']! + schedule.dateEnd.together;
          break;
        case 3:
          sum['wednesday'] = sum['wednesday']! + schedule.dateEnd.together;
          break;
        case 4:
          sum['thursday'] = sum['thursday']! + schedule.dateEnd.together;
          break;
        case 5:
          sum['friday'] = sum['friday']! + schedule.dateEnd.together;
          break;
        case 6:
          sum['saturday'] = sum['saturday']! + schedule.dateEnd.together;
          break;
        case 7:
          sum['sunday'] = sum['sunday']! + schedule.dateEnd.together;
      }
    });
    var isEmpty=sum['total']== 0;
    return isEmpty?Center(child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
              "images/no-schedule-no-schedule-png-194_181.png"),
          SizedBox(height: 5,),
          Text('Sorry no schedule this month',style: TextStyle(fontWeight:FontWeight.bold),)
        ],
      ),
    ),):LayoutBuilder(builder: (ctx, constraint) {
      final maxHeight = (constraint.maxHeight - 70)/1.3 ;
      final heightContainers = (maxHeight / 25) / 2;
      final widthContainer = 20.0;
      print(maxHeight * (sum['sunday']! / 24));
      //todo: final widthContainerz = maxWidth / 7;
      print(heightContainers);
      return Container(
        height:constraint.maxHeight,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height:maxHeight ,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    bars('sunday', 'Sun', widthContainer, maxHeight,
                        heightContainers, sum),
                    bars('monday', 'Mon', widthContainer, maxHeight,
                        heightContainers, sum),
                    bars('tuesday', 'Tue', widthContainer, maxHeight,
                        heightContainers, sum),
                    bars('wednesday', 'Wed', widthContainer, maxHeight,
                        heightContainers, sum),
                    bars('thursday', 'Thur', widthContainer, maxHeight,
                        heightContainers, sum),
                    bars('friday', 'Fri', widthContainer, maxHeight,
                        heightContainers, sum),
                    bars('saturday', 'Sat', widthContainer, maxHeight,
                        heightContainers, sum),
                  ],
                ),
              ),
            ),
           Container(
                padding: EdgeInsets.all(10),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text:
                          "NOTE: this displays the percentage of the total hours in each weekday over the total number of schedule hours for the month",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ])),
              ),
          ],
        ),
      );
    });
  }
}
