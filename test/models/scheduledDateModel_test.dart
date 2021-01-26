import 'package:demotest/models/scheduledDateModel.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  test('scheduledDate period to dateTime and color test',(){
    ScheduledDate schedule=ScheduledDate(title: 'test',description: 'describeded',
    period: 'monthly',positionInColor: 4,id: '123'
    );
    expect(schedule.id,'123');
    expect(schedule.color,ScheduledDate.colors[4]);
  });
  group('from and to map', (){
    test('scheduledDate from map',(){
      ScheduledDate schedule=ScheduledDate.toScheduledDate({'description':'describe',
        'date':"2020-03-11 09:15:00",'title':'test','positionInColor':2,
        'id':'123','period':'monthly'
      });

      expect(schedule,ScheduledDate(title: 'test',description: 'describe',
          period: 'monthly',positionInColor: 4,id: '123'
      ));
    });

    test('to map',(){
      ScheduledDate schedule=ScheduledDate.toScheduledDate({'description':'describe',
        'date':"2020-03-11 09:15:00",'title':'test','positionInColor':2,
        'id':'123','period':'monthly'
      });
      expect(schedule.toMap()['id'],'123' );
        });
  });

}