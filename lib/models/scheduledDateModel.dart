import 'package:demotest/models/localNotification.dart';
import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/sqlDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'localNotification.dart';

class LengthOfSchedule{
  late int hour;
  late int minutes;
  late int together;
  LengthOfSchedule({required this.hour,required this.minutes}){
    if(minutes.toString().length==1) {
      together = int.parse("$hour" +"0"+"$minutes");
    }else{
      together = int.parse("$hour$minutes");
    }
  }
   LengthOfSchedule.together({required this.together}){
     final los=hoursToString(together);
     hour=los.hour;
     minutes=los.minutes;
   }
   LengthOfSchedule hoursToString(int value){
     LengthOfSchedule los=LengthOfSchedule(hour: 0,minutes: 0);
     String stringValue=value.toString();
     switch(stringValue.length){
       case 1:
         los=LengthOfSchedule(hour: 0,minutes:value );
         break;
       case 2:
         los=LengthOfSchedule(hour: 0,minutes:value );
         break;
       case 3:
         int endMins=int.parse(stringValue.substring(1,3));
         int endHours=int.parse(stringValue.substring(0,1));

         los=LengthOfSchedule(hour: endHours,minutes:endMins);
         break;
       case 4:
         int endMins=int.parse(stringValue.substring(2,4));
         int endHours=int.parse(stringValue.substring(0,2));
         los=LengthOfSchedule(hour: endHours,minutes:endMins);
         break;
     }
     return los;
   }

}
class ScheduledDate {
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late Color color;
  late int positionInColor;
  late String period;
  late LengthOfSchedule dateEnd;
  static List<Color> colors = [
    Colors.brown[600]!,
    Colors.blueGrey[700]!,
    Colors.lime[800]!,
    Colors.purple,
    Colors.tealAccent,
    Colors.indigoAccent,
    Colors.blueAccent,
    Colors.deepOrange,
    Colors.amber
  ];
  ScheduledDate(
      {required this.id,
      required this.date,required this.dateEnd,
      required this.title,
      required this.description,
      required this.positionInColor,
      required this.period}) {
    this.color =this.positionInColor>colors.length-1?Colors.blueAccent:colors[this.positionInColor];
  }
  ScheduledDate.toScheduledDate(Map<String, dynamic> mapSchedule) {
    this.dateEnd=LengthOfSchedule.together(together: int.parse(mapSchedule['dateEnd']));
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
      'period': period,
      'dateEnd':dateEnd.together
    };
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    if(identical(other, this)){return true;}
    else if(this.runtimeType!=other.runtimeType){
      return false;}
    else {
      // ignore: test_types_in_equals
      ScheduledDate compare= other as ScheduledDate;
      return this.id==compare.id&&this.title==compare.title
          &&this.description==compare.description;
    }

  }
}




class AllScheduledDate extends StateNotifier<DateTime> {
  AllScheduledDate(this.dayyy) : super(dayyy);
  final DateTime dayyy;
  List<ScheduledDate> _dates = [];

  List<ScheduledDate> get dates {
    return [..._dates];
  }

  void addTodates(ScheduledDate schedule) {
    _dates.add(schedule);
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
      } else if (element.date.day == date.day && element.period == 'monthly' &&
          element.date.year == date.year) {
        return true;
      } else
        return false;
    });
    return index;
  }

  selectedDay(DateTime day) {
    state = day;
  }

  ScheduledDate findSchedule(String id) {
    var schedule = _dates.firstWhere((element) => element.id == id);
    return schedule;
  }

  Future<void> initialDbLoad() async {
    try {
      _dates = [];
      final scheduleList = await sql.getSchedulesFromDb();

      scheduleList.forEach((element) {
        final shh = ScheduledDate.toScheduledDate(element);
        _dates.add(shh);
      });
    }
    catch (e) {
      print(e);
    }
  }

  List<ScheduledDate> forThatMonth(Month month) {
    List<ScheduledDate> scheduledDate = [];
    month.dayAndDate.forEach((key, value) {
      value.forEach((date) {
        scheduledDate.addAll(forThatDay(date));
      });
    });
    return scheduledDate;
  }

  List<ScheduledDate> forThatDay(DateTime dayy) {
    List<ScheduledDate> forThatDay = [];
    _dates.forEach((element) {
      if (element.date.day == dayy.day &&
          element.date.month == dayy.month &&
          element.date.year == dayy.year &&
          element.period == 'once'
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

  Sql sql = SQLdatabase();
void changeSQL(Sql datatbase){
  sql=datatbase;
}
  Future<void> updateSchedule(DateTime date, LengthOfSchedule los, String title,
      String description,
      String period, int colorPosition, String id) async {
     var hasPassed=date.isAfter(DateTime.now());
    var schedule = ScheduledDate(
        id: id,
        dateEnd: los,
        date: date,
        description: description,
        title: title,
        period: period,
        positionInColor: colorPosition);
    int index = _dates.indexWhere((element) => id == element.id);
    if (index == -1) return;
    ScheduledDate beforeUpdate = _dates[index];
    _dates.removeWhere((element) {
      return element.id == id;
    });
    try {
      await removeNotification(int.parse(schedule.id));
      await sql.update(schedule);
      if(hasPassed)
      await addScheduleNotification(
          schedule.id, title, description, date);
      _dates.insert(index, schedule);
    } catch (e) {
      print(e);
      _dates.insert(index, beforeUpdate);
      throw PlatformException(code: '2', message: 'something went wrong');
    }
  }
  Future<void> addScheduleNotification(String id, String title,String description,DateTime date)async{
   await localNotification.addScheduleNotification(
        id, title, description, date);
  }
  Future<void> removeNotification (int id)async{
    await localNotification.removeNotification(id);
  }

  Future<void> addSchedule(DateTime date, LengthOfSchedule los, String title,
      String description,
      String period, int colorPosition) async {
    var hasPassed= date.isAfter(DateTime.now());
    var schedule = ScheduledDate(
        id: 'random',
        dateEnd: los,
        date: date,
        description: description,
        title: title,
        period: period,
        positionInColor: colorPosition);

      try {
        await sql.insert(schedule);
        print('pass');
        await initialDbLoad();
        print(_dates.length);
        if (hasPassed) {
          if (_dates.length == 0) {
            return;
          } else {
            await addScheduleNotification(
                _dates[_dates.length - 1].id, title, description, date);
          }
        }
      } on PlatformException catch(_){
        print('caught you');
        throw PlatformException(code: '3', message: 'something went wrong');
      }
  }

  Future<void> removeSchedule(ScheduledDate schedule) async {
    int index = _dates.indexWhere((element) => schedule.id == element.id);
    print(index);
    if (index == -1) {return;}
    final removed = schedule;
    _dates.removeWhere((element) {
      return element.id == schedule.id;
    });
    try {
      await sql.delectSchedule(schedule.id);
      await removeNotification(int.parse(schedule.id));
    } catch (e) {
      print(e);
      print('enter');
      _dates.insert(index, removed);
      throw PlatformException(code: '5', message: 'failed to delete');
    }
  }
}