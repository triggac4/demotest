import 'package:intl/intl.dart';
import 'monthModel.dart';

abstract class YearBase {
  List<Month> generateMonths();
}

class Year implements YearBase {
  final int id;
  Year({this.id});

  List<Month> generateMonths() {
    List<DateTime> date = [];
    List<Month> months = [];
    List.generate(12, (index) {
      String monthName = '';
      switch (index) {
        case 0:
          monthName = 'January';
          break;
        case 1:
          monthName = 'Febuary';
          break;
        case 2:
          monthName = 'March';
          break;
        case 3:
          monthName = 'April';
          break;
        case 4:
          monthName = 'May';
          break;
        case 5:
          monthName = 'June';
          break;
        case 6:
          monthName = 'July';
          break;
        case 7:
          monthName = 'August';
          break;
        case 8:
          monthName = 'September';
          break;
        case 9:
          monthName = 'October';
          break;
        case 10:
          monthName = 'November';
          break;
        case 11:
          monthName = 'December';
          break;
        default:
          monthName = 'Unknown';
      }
      Month month = Month(id: monthName, days: []);
      months.add(month);
    });
    date = [];
    DateTime january1 = DateTime.parse('${this.id}' + '0101');

    List.generate(367, (index) {
      if (january1.add(Duration(days: index)).year.toString() !=
          this.id.toString()) return;
      date.add(january1.add(Duration(days: index)));

      switch (DateFormat('MM').format(date[index])) {
        case "01":
          months[0].days.add(date[index]);
          break;
        case "02":
          months[1].days.add(date[index]);
          break;
        case "03":
          months[2].days.add(date[index]);
          break;
        case "04":
          months[3].days.add(date[index]);
          break;
        case "05":
          months[4].days.add(date[index]);
          break;
        case "06":
          months[5].days.add(date[index]);
          break;
        case "07":
          months[6].days.add(date[index]);
          break;
        case "08":
          months[7].days.add(date[index]);
          break;
        case "09":
          months[8].days.add(date[index]);
          break;
        case "10":
          months[9].days.add(date[index]);
          break;
        case "11":
          months[10].days.add(date[index]);
          break;
        case "12":
          months[11].days.add(date[index]);
          break;
      }
    });
    return months;
  }
}
