import 'package:demotest/models/monthModel.dart';
import 'package:demotest/models/sheduledDateProvider.dart';
import 'package:demotest/screens/scaffoldButtomBar.dart';
import 'package:demotest/widgets/monthWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CalenderListView extends StatefulWidget {
  CalenderListView({required this.generated});
  final List<Month> generated;

  @override
  _CalenderListViewState createState() => _CalenderListViewState();
}

class _CalenderListViewState extends State<CalenderListView> {
  List<Month> get generated {
    return widget.generated;
  }
  final globalKey = GlobalKey();
  void autoScroll() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if(generated[0].firstDay.year==DateTime.now().year){
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp){

      scrollController
        .position
        .ensureVisible(((globalKey.currentContext)?.findRenderObject()) as RenderObject,duration: Duration(milliseconds: 300));
    });
    }
    final scheduledDate = ScheduledDateProvider.of(context);

    var provider = StateNotifierProvider((ref) => scheduledDate);
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
          children:generated.map((generated) {
            return InkWell(
                key: (DateTime.now().month) == (generated.firstDay.month)  ? globalKey : null,
                onTap: () {
                  // ignore: invalid_use_of_protected_member
                  context.read(provider).state = generated.firstDay;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          ScaffoldButtomBar(month: generated)));
                },
                child: Container(
                    child: MonthHomeWidget(
                      month: generated,
                    )));
          }).toList(),


          ),
    );
  }
}
// ListView.builder(
// controller: scrollController,
// itemCount: generated.length,
// itemBuilder: (_, index) {
// return InkWell(
// key: DateTime.now().month -1 == index ? globalKey : null,
// onTap: () {
// // ignore: invalid_use_of_protected_member
// context.read(provider).state = generated[index].firstDay;
// Navigator.of(context).push(MaterialPageRoute(
// builder: (_) =>
// ScaffoldButtomBar(month: generated[index])));
// },
// child: Container(
// child: MonthHomeWidget(
// month: generated[index],
// )));
// });
