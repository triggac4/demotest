import 'dart:io';

import 'package:demotest/models/scheduledDateModel.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:sqflite/sqflite.dart';

abstract class Sql {
  Future<void> insert(ScheduledDate date);
  Future<List<Map<String, dynamic>>> getSchedulesFromDb();
  Future<void> delectSchedule(String id);
}

class SQLdatabase implements Sql {
  static Database _database;

  Future<void> _createDatebase() async {
    print('created');
    try {
      final Directory directory = await path.getApplicationDocumentsDirectory();
      final String pathe = directory.path + "database.txt";
      _database =
          await openDatabase(pathe, onCreate: (Database db, int version) {
        db.execute(
            "CREATE TABLE scheduledTable (id TEXT PRIMARY KEY, title TEXT, description TEXT, date TEXT,positionInColor INTEGER)");
      }, version: 1);
    } catch (e) {
      print('error while creating');
      print(e);
    }
  }

  Future<void> insert(ScheduledDate date) async {
    if (_database == null) {
      await _createDatebase();
    }
    try {
      final db = _database;
      await db.insert("scheduledTable", date.toMap());
    } catch (e) {
      print('error while inserting');
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getSchedulesFromDb() async {
    if (_database == null) {
      await _createDatebase();
    }
    final schedules = await _database.rawQuery('SELECT * FROM scheduledTable');
    if (schedules == null) {
      return [];
    } else
      return schedules;
  }

  Future<void> delectSchedule(String id) async {
    try {
      await _database.rawDelete("DELETE FROM scheduledTable WHERE id='$id'");
    } catch (e) {
      print('thrown');
      throw e;
    }
  }
}
