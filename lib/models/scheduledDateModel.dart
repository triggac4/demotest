import 'dart:math';

import 'package:demotest/models/sqlDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ScheduledDate {
  String key = UniqueKey().toString();
  String title;
  String description;
  DateTime date;
  Color color;
  int positionInColor;
  String period;
  List<Color> colors = [
    Colors.brown[200],
    Colors.blueGrey[700],
    Colors.deepOrange[500],
    Colors.orange,
    Colors.lime[800]
  ];
  ScheduledDate(
      {this.date,
      this.title,
      this.description,
      positionInColor = -1,
      this.period}) {
    var rand = new Random();
    if (positionInColor == -1)
      this.positionInColor = rand.nextInt(this.colors.length);
    else
      this.positionInColor = positionInColor;
    this.color = this.colors[this.positionInColor];
  }
  ScheduledDate.toScheduledDate(Map<String, dynamic> mapSchedule) {
    this.date = DateTime.parse(mapSchedule['date']);
    this.description = mapSchedule['description'];
    this.title = mapSchedule['title'];
    this.positionInColor = mapSchedule['positionInColor'];
    this.key = mapSchedule['id'];
    this.color = this.colors[this.positionInColor];
    this.period = mapSchedule['period'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': key,
      "title": title,
      'description': description,
      'date': date.toString(),
      'positionInColor': positionInColor,
      'period': period
    };
  }
}

class AllScheduledDate extends StateNotifier<DateTime> {
  AllScheduledDate(this.dayyy) : super(dayyy);
  final DateTime dayyy;
  List<ScheduledDate> _dates = [];
  List<ScheduledDate> get dates {
    return [..._dates];
  }

  int firstScheduleOfTheDay(DateTime date) {
    var index = _dates.indexWhere((element) {
      if (element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year) {
        return true;
      } else if (element.date.day == date.day &&
          element.date.month == date.month &&
          element.period == 'yearly') {
        return true;
      } else if (element.date.day == date.day && element.period == 'monthly') {
        return true;
      } else
        return false;
    });
    return index;
  }

  selectedDay(DateTime day) {
    state = day;
  }

  Future<void> initialDbLoad() async {
    Sql sql = SQLdatabase();
    try {
      _dates = [];
      final scheduleList = await sql.getSchedulesFromDb();
      scheduleList.forEach((element) {
        final shh = ScheduledDate.toScheduledDate(element);
        _dates.add(shh);
      });
    } catch (e) {
      print(e);
    }
  }

  List<ScheduledDate> forThatDay(DateTime dayy) {
    List<ScheduledDate> forThatDay = [];
    _dates.forEach((element) {
      if (element.date.day == dayy.day &&
          element.date.month == dayy.month &&
          element.date.year == dayy.year) {
        forThatDay.add(element);
      } else if (element.date.day == dayy.day &&
          element.date.month == dayy.month &&
          element.period == 'yearly') {
        forThatDay.add(element);
      } else if (element.date.day == dayy.day && element.period == 'monthly') {
        forThatDay.add(element);
      }
    });
    return forThatDay;
  }

  final Sql sql = SQLdatabase();
  Future<void> addSchedule(
      DateTime date, String title, String description, String period) async {
    var schedule = ScheduledDate(
        date: date, description: description, title: title, period: period);
    await sql.insert(schedule);
    _dates.add(schedule);
  }

  Future<void> removeSchedule(ScheduledDate schedule) async {
    int index = _dates.indexWhere((element) => schedule.key == element.key);
    print(index);
    final removed = schedule;
    _dates.removeWhere((element) {
      return element.key == schedule.key;
    });
    try {
      await sql.delectSchedule(schedule.key);
    } catch (e) {
      print(e);
      if (index >= 0) {
        _dates.insertAll(index, [removed]);
      }
    }
  }
}
