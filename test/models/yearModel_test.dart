import 'package:demotest/models/yearModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('generate months', (){
    Year year=Year(id: DateTime.now().year);
    final months=year.generateMonths();

    expect(months.length,12);
    expect(months[0].id,'January');
    int total=0;
 months.forEach((element) {
   element.dayAndDate.forEach((key, value) {
     total=total+value.length;
   });
 });
 bool numberOfDays=(total>=365)&&(total<=366);
 expect(numberOfDays,true);
  });
}