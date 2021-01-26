import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/models/yearModel.dart';
import 'package:demotest/screens/monthDetails.dart';
import 'package:demotest/screens/scaffoldButtomBar.dart';
import 'package:demotest/widgets/monthWidget.dart';
import 'package:demotest/widgets/selectYear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

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

  Year year = Year();
  List<Month> generated = [];

  Widget build(BuildContext context) {
    year = Year(
      id: val,
    );

    generated = year.generateMonths();
    final scheduledDate = ScheduledDateProvider.of(context);
    var provider = StateNotifierProvider((ref) => scheduledDate);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: RaisedButton(
            child: Text("$val"),
            padding: EdgeInsets.zero,
            color: Theme.of(context).primaryColor,
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
              return ListView(children: <Widget>[
                for (int index = 0; index < generated.length; index++)
                  InkWell(
                      onTap: () {
                        // ignore: invalid_use_of_protected_member
                        context.read(provider).state =
                            generated[index].firstDay;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>ScaffoldButtomBar(month:generated[index])));
                      },
                      child: Container(
                          child: MonthHomeWidget(
                        month: generated[index],
                      )))
              ]);
            }else{
              return Center(child: Text('error Loading database'),);
            }

          }),
    );
  }
}
