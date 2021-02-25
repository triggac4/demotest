import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/sqlDatabase.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSql extends Mock implements Sql{
}
void main() {
  MockSql mock = MockSql();
  AllScheduledDate allSchedule;
  ScheduledDate schedule;
  ScheduledDate schedule2;
  ScheduledDate schedule3;
  group('sqlite database', () {
    setUp(() {
      allSchedule = AllScheduledDate(DateTime.now());
      allSchedule.sql = mock;
      schedule = ScheduledDate(
          positionInColor: 1,
          period: 'monthly',
          description: 'describe',
          title: 'first',
          id: '123',
          date: DateTime.now().add(Duration(days: 1)));
      schedule2 = ScheduledDate(
          positionInColor: 1,
          period: 'monthly',
          description: 'describe',
          title: 'second',
          id: '1235',
          date: DateTime.now().add(Duration(days: 2)));
      schedule3 = ScheduledDate(
          positionInColor: 1,
          period: 'monthly',
          description: 'describe',
          title: 'third',
          id: '1234',
          date: DateTime.now().add(Duration(days: 3)));
      allSchedule.addTodates(schedule);
      allSchedule.addTodates(schedule2);
      allSchedule.addTodates(schedule3);
    });
    subFailedDeleteSqlMethods() async {
      when(mock.delectSchedule(any)).thenThrow(
          PlatformException(code: 'failed', message: 'delete failed'));
    }
    subFailedInsertSqlMethods() async {
      when(mock.insert(any)).thenThrow(
          PlatformException(code: 'failed', message: 'insert failed'));
    }
    subFailedUpdateSqlMethods() async {
      when(mock.update(any)).thenThrow(
          PlatformException(code: 'failed', message: 'update failed'));
    }

    test('insert schedule valid input', () async {
      await allSchedule.addSchedule(DateTime.now().add(Duration(days: 1)),
          LengthOfSchedule(hour: 1, minutes: 00), 'test', 'describe', 'yearly',
          3);
      expect(allSchedule.dates.length, 4);
    });
    test('insert schedule failed to insert to SQL', () async {
      subFailedInsertSqlMethods();
      try {
        await allSchedule.addSchedule(
            DateTime.now(), LengthOfSchedule(hour: 1, minutes: 00), 'test',
            'describe', 'yearly', 3);
      } on PlatformException catch (e) {

      }
      expect(allSchedule.dates.length, 3);
    });
    test('update schedule valid input', () async {
      await allSchedule.updateSchedule(
          DateTime.now().add(Duration(days: 1)),
          LengthOfSchedule(hour: 1, minutes: 00),
          'testz',
          'describe',
          'yearly',
          3,
          '1234');
      ScheduledDate updatedSchedule = allSchedule.dates.firstWhere((
          element) => element.id == '1234');
      expect(updatedSchedule.title, "testz");
    });
    test('update schedule failedTo Update to SQL', () async {
      subFailedUpdateSqlMethods();
      try {
        await allSchedule.updateSchedule(
            DateTime.now(),
            LengthOfSchedule(hour: 1, minutes: 00),
            'test',
            'describe',
            'yearly',
            3,
            '1234');
      } on PlatformException catch (e) {

      }
      ScheduledDate updatedSchedule = allSchedule.dates.firstWhere((
          element) => element.id == '1234');
      expect(updatedSchedule.title, "third");
    });

    test('delete schedule deleted at SQL', () async {
      await allSchedule.removeSchedule(schedule3);
      expect(allSchedule.dates.length, 2);
    });
    test('delete schedule failed To delete to SQL', () async {
      subFailedDeleteSqlMethods();
      try {
        await allSchedule.removeSchedule(schedule3);
      } on PlatformException catch (e) {
      }
      expect(allSchedule.dates.length, 3);
      expect(allSchedule.dates[2].id, "1234");
    });
  });
}