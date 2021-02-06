import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/yearModel.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  test('month class',(){
    Year year=Year(id: 2020);
    List<Month> months=year.generateMonths();
    expect(months[0].firstDay.day,1);
  });
}