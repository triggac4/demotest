import 'monthModel.dart';

abstract class YearBase {
  List<Month> generateMonths();
}

class Year implements YearBase {
  final int id;

  Year({this.id});
@override
  List<Month> generateMonths() {
  List<DateTime> date = [];
  List<Month> months = [
    Month(id: 'January'),
    Month(id: 'February'),
    Month(id: 'March'),
    Month(id: 'April'),
    Month(id: 'May'),
    Month(id: 'June'),
    Month(id: 'July'),
    Month(id: 'August'),
    Month(id: 'September'),
    Month(id: 'October'),
    Month(id: 'November'),
    Month(id: 'December')
  ];
  date = [];

  arrangeWeekday({Month month,DateTime date}){
   if(date.day==1){
     month.firstDay=date;
   }
    switch (date.weekday) {
      case 7:
        month.dayAndDate['Sunday'].add(date);
        break;
      case 1:
        month.dayAndDate['Monday'].add(date);
        break;
      case 2:
        month.dayAndDate['Tuesday'].add(date);
        break;
      case 3:
        month.dayAndDate['Wednesday'].add(date);
        break;
      case 4:
    month.dayAndDate['Thursday'].add(date);
    break;
    case 5:
    month.dayAndDate['Friday'].add(date);
    break;
    case 6:
    month.dayAndDate['Saturday'].add(date);
    break;
  }
  }

    DateTime january1 = DateTime.parse('${this.id}' + '0101');
    List.generate(367, (index) {
      if (january1.add(Duration(days: index)).year.toString() !=
          this.id.toString()) return;

      date.add(january1.add(Duration(days: index)));
      switch (date[index].month) {
        case 1:
          arrangeWeekday(date: date[index],month: months[0]);
          break;
        case 2:
          arrangeWeekday(date: date[index],month: months[1]);

          break;
        case 3:
          arrangeWeekday(date: date[index],month: months[2]);
          break;
        case 4:

          arrangeWeekday(date: date[index],month: months[3]);

          break;
        case 5:
          arrangeWeekday(date: date[index],month: months[4]);

          break;
        case 6:
          arrangeWeekday(date: date[index],month: months[5]);
          break;
        case 7:
          arrangeWeekday(date: date[index],month: months[6]);
          break;
        case 8:
          arrangeWeekday(date: date[index],month: months[7]);

          break;
        case 9:
          arrangeWeekday(date: date[index],month: months[8]);
          break;
        case 10:
          arrangeWeekday(date: date[index],month: months[9]);
          break;
        case 11:
          arrangeWeekday(date: date[index],month: months[10]);
          break;
        case 12:
          arrangeWeekday(date: date[index],month: months[11]);
          break;

      }

    });

    print('generated');
    return months;
  }
}
