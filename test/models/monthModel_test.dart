import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/yearModel.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  test('month class',(){
    Year year=Year(id: DateTime.now().year);
    List<Month> months=year.generateMonths();
    expect(months[0].firstDay.day,1);
    expect(months[0].dayAndDate.length,7);
    int month=DateTime.now().month;
    expect(months[month-1].firstDay.month,month);
  });
}