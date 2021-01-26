import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/screens/homeScreen.dart';
import 'package:demotest/screens/scaffoldButtomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScheduledDateProvider(
      schedule: AllScheduledDate(DateTime.now()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blueAccent[100],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Calender(),
      ),
    );
  }
}
