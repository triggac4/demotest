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
    Month(id: 'Febuary'),
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

  arrangeWeekday({List<Month> monthss,int monthIndex,DateTime date}){
    switch (date.weekday) {
      case 7:
        monthss[monthIndex].dayAndDate['Sunday'].add(date);

        break;
      case 1:
        monthss[monthIndex].dayAndDate['Monday'].add(date);
        break;
      case 2:
        monthss[monthIndex].dayAndDate['Tuesday'].add(date);
        break;
      case 3:
        monthss[monthIndex].dayAndDate['Wednesday'].add(date);
        break;
      case 4:
    monthss[monthIndex].dayAndDate['Thursday'].add(date);
    break;
    case 5:
    monthss[monthIndex].dayAndDate['Friday'].add(date);
    break;
    case 6:
    monthss[monthIndex].dayAndDate['Saturday'].add(date);
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
          arrangeWeekday(monthIndex: 0,date: date[index],monthss: months);
          break;
        case 2:
          arrangeWeekday(monthIndex: 1,date: date[index],monthss: months);

          break;
        case 3:
          arrangeWeekday(monthIndex: 2,date: date[index],monthss: months);
          break;
        case 4:

          arrangeWeekday(monthIndex: 3,date: date[index],monthss: months);

          break;
        case 5:
          arrangeWeekday(monthIndex: 4,date: date[index],monthss: months);

          break;
        case 6:
          arrangeWeekday(monthIndex: 5,date: date[index],monthss: months);
          break;
        case 7:
          arrangeWeekday(monthIndex: 6,date: date[index],monthss: months);
          break;
        case 8:
          arrangeWeekday(monthIndex: 7,date: date[index],monthss: months);

          break;
        case 9:
          arrangeWeekday(monthIndex: 8,date: date[index],monthss: months);
          break;
        case 10:
          arrangeWeekday(monthIndex: 9,date: date[index],monthss: months);
          break;
        case 11:
          arrangeWeekday(monthIndex: 10,date: date[index],monthss: months);
          break;
        case 12:
          arrangeWeekday(monthIndex: 11,date: date[index],monthss: months);
          break;
      }
    });

    print('generated');
    return months;
  }
}
