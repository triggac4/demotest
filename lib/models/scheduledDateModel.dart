import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/sqlDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ScheduledDate {
  String id = UniqueKey().toString();
  String title;
  String description;
  DateTime date;
  Color color;
  int positionInColor;
  String period;
  static List<Color> colors = [
    Colors.brown[600],
    Colors.blueGrey[700],
    Colors.lime[800],
    Colors.purple,
    Colors.tealAccent,
    Colors.indigoAccent,
    Colors.blueAccent,
    Colors.deepOrange,
    Colors.amber
  ];
  ScheduledDate(
      {this.id,
      this.date,
      @required this.title,
      @required this.description,
      @required this.positionInColor,
      @required this.period}) {
    this.color =this.positionInColor>colors.length-1?Colors.blueAccent:colors[this.positionInColor];
  }
  ScheduledDate.toScheduledDate(Map<String, dynamic> mapSchedule) {
    this.date = DateTime.parse(mapSchedule['date']);
    this.description = mapSchedule['description'];
    this.title = mapSchedule['title'];
    this.positionInColor = mapSchedule['positionInColor'];
    this.id = mapSchedule['id'].toString();
    this.color =this.positionInColor>colors.length-1?Colors.blueAccent:colors[this.positionInColor];
    this.period = mapSchedule['period'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "title": title,
      'description': description,
      'date': date.toString(),
      'positionInColor': positionInColor,
      'period': period
    };
  }
  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    if(identical(other, this)){return true;}
    else if(this.runtimeType!=other.runtimeType){
      return false;}
    else {
      ScheduledDate compare=other;
      return this.id==compare.id&&this.title==compare.title
          &&this.description==compare.description;
    }

    return super == other;
  }
}




class AllScheduledDate extends StateNotifier<DateTime> {
  AllScheduledDate(this.dayyy) : super(dayyy);
  final DateTime dayyy;
  List<ScheduledDate> _dates = [];
  List<ScheduledDate> get dates {
    return [..._dates];
  }
void addTodates(ScheduledDate schedule){
    _dates.add(schedule);
}
  int firstScheduleOfTheDay(DateTime date) {
    if(date==null){
      return -1;}
    var index = _dates.indexWhere((element) {
      if (element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year) {
        return true;
      } else if (element.date.day == date.day &&
          element.date.month == date.month &&
          element.period == 'yearly') {
        return true;
      } else if (element.date.day == date.day && element.period == 'monthly'&& element.date.year==date.year) {
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
List<ScheduledDate> forThatMonth(Month month){
    List<ScheduledDate> scheduledDate=[];
    if(month==null){return scheduledDate;}
    month.dayAndDate.forEach((key, value) {
      value.forEach((date) {
        scheduledDate.addAll(forThatDay(date));
      });
    });
    return scheduledDate;
}
  List<ScheduledDate> forThatDay(DateTime dayy) {
    List<ScheduledDate> forThatDay = [];
    if(dayy==null)return forThatDay;
    _dates.forEach((element) {
      if (element.date.day == dayy.day &&
          element.date.month == dayy.month &&
          element.date.year == dayy.year&&
      element.period=='once'
      ) {
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
  Future<void> updateSchedule(DateTime date, String title, String description,
      String period, int colorPosition, String id) async {
    print(id);
    var schedule = ScheduledDate(
        id: id,
        date: date,
        description: description,
        title: title,
        period: period,
        positionInColor: colorPosition);
    int index = _dates.indexWhere((element) => id == element.id);
    _dates.removeWhere((element) {
      return element.id == id;
    });
    await sql.update(schedule);
    _dates.insert(index, schedule);
  }

  Future<void> addSchedule(DateTime date, String title, String description,
      String period, int colorPosition) async {
    var schedule = ScheduledDate(
        date: date,
        description: description,
        title: title,
        period: period,
        positionInColor: colorPosition);
    await sql.insert(schedule);
    _dates.add(schedule);
  }

  Future<void> removeSchedule(ScheduledDate schedule) async {
    int index = _dates.indexWhere((element) => schedule.id == element.id);
    print(index);
    final removed = schedule;
    _dates.removeWhere((element) {
      return element.id == schedule.id;
    });
    try {
      await sql.delectSchedule(schedule.id);
    } catch (e) {
      print(e);
      if (index >= 0) {
        _dates.insertAll(index, [removed]);
      }
    }
  }
}
