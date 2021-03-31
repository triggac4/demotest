import 'package:demotest/models/localNotification.dart';
import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/models/yearModel.dart';
import 'package:demotest/screens/scheduleDetails.dart';
import 'package:demotest/widgets/CalenderListView.dart';
import 'package:demotest/widgets/selectYear.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Calender extends StatefulWidget {
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  Future<void> _loadInitially() async {
    await ScheduledDateProvider.of(context).initialDbLoad();
  }

  int val = DateTime.now().year;

  changeYear(int newYear) {
    setState(() {
      val = newYear;
    });
  }
  initState() {
    super.initState();
    localNotification.onSelectNotification(onSelect);
    year = Year(
      id: val,
    );
  }
  late Year year = Year(id: val);
  List<Month> generated = [];
  Future<void> onSelect(String payload)async{
    final scheduled=ScheduledDateProvider.of(context);
    final schedule = scheduled.findSchedule(payload);
    print('id: ${schedule.id} description: ${schedule.description}');

    await Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (ctx)=>ScheduleDetail(schedule)
    ));
  }
  Widget build(BuildContext context) {
    year = Year(id: val);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: ElevatedButton(
            child: Text("$val",style: TextStyle(color: Colors.black),),
            style: ButtonStyle(
              padding:MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all( Theme.of(context).primaryColor)
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return SelectYear(val, changeYear);
                  });
            },
          )),
      body: FutureBuilder(
          future: _loadInitially(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              generated = year.generateMonths();
              return CalenderListView(generated: generated,);
            } else {
              return Center(
                child: Text('error Loading database'),
              );
            }
          }),
    );
  }
}
