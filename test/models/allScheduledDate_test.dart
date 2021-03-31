import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/scheduledDateModel.dart';
import 'package:demotest/models/yearModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('iterable methods', () {
    late AllScheduledDate allSchedule;
    late ScheduledDate  schedule;
    late ScheduledDate schedule2;
    late ScheduledDate schedule3;
    setUp((){
      allSchedule = AllScheduledDate(DateTime.now());
      schedule = ScheduledDate(
          positionInColor: 1,
          period: 'monthly',
          description: 'describe',
          title: 'first',
          id: '123',
          dateEnd: LengthOfSchedule(minutes: 10, hour: 2),
          date: DateTime.now().subtract(Duration(days: 1)));
      schedule2 = ScheduledDate(
          positionInColor: 1,
          period: 'monthly',
          description: 'describe',
          title: 'second',
          id: '1235',
      dateEnd: LengthOfSchedule(minutes: 10, hour: 2),
          date: DateTime.now());
      schedule3 = ScheduledDate(
          positionInColor: 1,
          period: 'monthly',
          description: 'describe',
          title: 'third',
      dateEnd: LengthOfSchedule(minutes: 10, hour: 2),
          id: '1234',
          date: DateTime.now());
      allSchedule.addTodates(schedule);
      allSchedule.addTodates(schedule2);
      allSchedule.addTodates(schedule3);
    });

    test('firstScheduleOfTheDay', () {
      expect(allSchedule.firstScheduleOfTheDay(DateTime.now()),1);
    });
    test('forThatDay', (){
      final listOfSchedules= allSchedule.forThatDay(DateTime.now());
      expect(listOfSchedules[0].title, 'second');
       });

    test('forThatMonth',(){
       Year year=Year(id: 2020);
       List<Month> months=year.generateMonths();
       expect(allSchedule.forThatMonth(months[0]).length, 3);
        });
  });
}
