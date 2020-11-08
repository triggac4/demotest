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
    DateTime january1 = DateTime.parse('${this.id}' + '0101');
    List.generate(367, (index) {
      if (january1.add(Duration(days: index)).year.toString() !=
          this.id.toString()) return;
      date.add(january1.add(Duration(days: index)));

      switch (DateFormat('MM').format(date[index])) {
        case "01":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[0].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[0].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[0].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[0].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[0].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[0].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[0].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "02":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[1].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[1].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[1].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[1].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[1].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[1].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[1].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "03":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[2].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[2].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[2].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[2].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[2].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[2].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[2].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "04":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[3].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[3].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[3].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[3].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[3].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[3].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[3].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "05":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[4].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[4].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[4].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[4].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[4].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[4].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[4].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "06":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[5].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[5].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[5].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[5].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[5].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[5].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[5].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "07":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[6].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[6].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[6].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[6].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[6].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[6].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[6].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "08":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[7].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[7].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[7].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[7].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[7].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[7].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[7].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "09":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[8].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[8].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[8].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[8].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[8].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[8].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[8].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "10":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[9].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[9].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[9].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[9].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[9].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[9].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[9].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "11":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[10].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[10].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[10].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[10].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[10].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[10].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[10].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
        case "12":
          switch (DateFormat('EEEE').format(date[index])) {
            case 'Sunday':
              months[11].dayAndDate['Sunday'].add(date[index]);
              break;
            case 'Monday':
              months[11].dayAndDate['Monday'].add(date[index]);
              break;
            case 'Tuesday':
              months[11].dayAndDate['Tuesday'].add(date[index]);
              break;
            case 'Wednesday':
              months[11].dayAndDate['Wednesday'].add(date[index]);
              break;
            case 'Thursday':
              months[11].dayAndDate['Thursday'].add(date[index]);
              break;
            case 'Friday':
              months[11].dayAndDate['Friday'].add(date[index]);
              break;
            case 'Saturday':
              months[11].dayAndDate['Saturday'].add(date[index]);
              break;
          }

          break;
      }
    });
    print('generated');
    return months;
  }
}
