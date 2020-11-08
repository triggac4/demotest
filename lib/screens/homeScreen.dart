import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/models/yearModel.dart';
import 'package:demotest/screens/monthDetails.dart';
import 'package:demotest/widgets/monthWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class Calender extends StatefulWidget {
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadInitially();
  }

  bool _isLoading = false;
  Future<void> _loadInitially() async {
    setState(() {
      _isLoading = true;
    });
    await ScheduledDateProvider.of(context).initialDbLoad();
    setState(() {
      _isLoading = false;
    });
  }

  int val = 2020;
  List<int> years = [
    2015,
    2016,
    2017,
    2018,
    2019,
    2020,
    2021,
    2022,
    2023,
    2024
  ];
  Year year = Year(id: 2020);

  Widget build(BuildContext context) {
    final scheduledDate = ScheduledDateProvider.of(context);
    var provider = StateNotifierProvider((ref) => scheduledDate);
    year = Year(id: val);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: DropdownButton(
          items: years.map((e) {
            return DropdownMenuItem(
              child: Text(e.toString()),
              value: e,
            );
          }).toList(),
          onChanged: (valu) {
            setState(() {
              val = valu;
            });
          },
          value: null,
          underline: Text('$val'),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(children: <Widget>[
              for (int index = 0; index < year.generateMonths().length; index++)
                InkWell(
                    onTap: () {
                      // ignore: invalid_use_of_protected_member
                      context.read(provider).state =
                          year.generateMonths()[index].days[0];
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              MonthDetails(year.generateMonths()[index])));
                    },
                    child: Container(
                        child: MonthHomeWidget(
                      month: year.generateMonths()[index],
                    )))
            ]),
    );
  }
}