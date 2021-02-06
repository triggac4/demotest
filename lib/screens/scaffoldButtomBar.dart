import 'package:demotest/models/monthModel.dart';
import 'package:demotest/screens/monthScheduleList.dart';
import 'package:demotest/screens/homeScreen.dart';
import 'package:demotest/screens/monthDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ScaffoldButtomBar extends StatefulWidget{
  const ScaffoldButtomBar({Key key, this.month}) : super(key: key);

  final Month month;
  @override
  _ScaffoldButtomBarState createState() => _ScaffoldButtomBarState();
}

class _ScaffoldButtomBarState extends State<ScaffoldButtomBar> {
  final homeScreenNav=GlobalKey<NavigatorState>();
  final scheduleScreenNav=GlobalKey<NavigatorState>();
  List<GlobalKey<NavigatorState>> navStates=[];
void initState(){
  super.initState();
  tabView= {
      'homeScreen':  MonthDetails(widget.month),
      'scheduleScreen':  MonthScheduleList(month:widget.month) ,
    };
  page='homeScreen';
  navStates=[homeScreenNav,scheduleScreenNav];
}
  Map<String,Widget> tabView;
String page;
  int pageIndex=0;
  final scaffold=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:scaffold,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context,).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )

      ),
      body: Column(
        children: [
          Expanded(child: tabView[page]),
          
          BottomNavigationBar(items: tabBar(),onTap: (index){
            setState(() {
              pageIndex=index;
              page=index==0?'homeScreen':'scheduleScreen';
            });
          },

            selectedFontSize: 20,
            selectedIconTheme: IconThemeData(color:Theme.of(context).primaryColor,size: 30),
            currentIndex:pageIndex,

          ),
        ],
      ),


    );
  }

  List<BottomNavigationBarItem> tabBar(){
    return [
      BottomNavigationBarItem(icon: Icon(Icons.today_outlined),label: 'Calender',backgroundColor:Colors.blueAccent,),
      BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Schedules',backgroundColor:Colors.blueAccent,)
    ];
  }
}
