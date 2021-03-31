import 'dart:io';

import 'package:demotest/models/scheduledDateModel.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:sqflite/sqflite.dart';

abstract class Sql {
  Future<void> insert(ScheduledDate date);

  Future<void> update(ScheduledDate date);

  Future<List<Map<String, dynamic>>> getSchedulesFromDb();

  Future<void> delectSchedule(String id);
}

class SQLdatabase implements Sql {
  static Database? _database;

  Future<void> _createDatebase() async {
    print('created');
    try {
      final Directory directory = await path.getApplicationDocumentsDirectory();
      final String pathe = directory.path + "database.txt";
      _database =
          await openDatabase(pathe, onCreate: (Database db, int version) {
        db.execute(
            "CREATE TABLE scheduledTable (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT,dateEnd TEXT, positionInColor INTEGER,period TEXT)");
      }, version: 1);
    } catch (e) {
      print('error while creating');
      print(e);
    }
  }

  @override
  Future<void> insert(ScheduledDate date) async {
    try {
      if (_database == null) {
        await _createDatebase();
      }
       final db = _database;
      var schedule=date.toMap();
      schedule['id']=null;
      await db?.insert("scheduledTable",schedule
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(ScheduledDate schedule) async {
    if (_database == null) {
      await _createDatebase();
    }
    try {
      await _database?.update(
        'scheduledTable',
        schedule.toMap(),
        where: 'id=${schedule.id}',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSchedulesFromDb() async {
    if (_database == null) {
      await _createDatebase();
    }
    try {
      final schedules =
          await _database?.rawQuery('SELECT * FROM scheduledTable');
      if (schedules == null) {
        return [];
      } else
        return schedules;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delectSchedule(String id) async {
    if (_database == null) {
      await _createDatebase();
    }
    try {
      await _database?.rawDelete("DELETE FROM scheduledTable WHERE id='$id'");
    } catch (e) {
      print('thrown');
      rethrow;
    }
  }
}
