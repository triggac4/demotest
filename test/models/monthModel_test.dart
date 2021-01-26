import 'package:demotest/models/monthModel.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  test('month class',(){
   Month month=Month(id: 'something');
    expect(month.firstDay.day,22);
  });
}