import 'package:flutter/material.dart';

class HowLong extends StatefulWidget {
  const HowLong(
      {Key key, @required this.initialHowLong, @required this.changed})
      : assert(initialHowLong != null, changed != null),
        super(key: key);
  final int initialHowLong;
  final Function(int changed) changed;

  @override
  _HowLongState createState() => _HowLongState();
}

class _HowLongState extends State<HowLong> {
  Widget eachContainer(String val, bool border) {
    return Container(
      decoration: BoxDecoration(
          border: border ? Border.all(color: Colors.black) : null,
          borderRadius: BorderRadius.circular(10)),
      constraints: BoxConstraints(minHeight: 30, minWidth: 30),
      alignment: Alignment.center,
      child: Text('$val',
          style: TextStyle(
            fontSize: 25,
          )),
    );
  }
changeToString(int length){
  switch(length){
    case 1:
      currentHowLongz = "000"+changedHowLong.toString();
      break;
    case 2:
      currentHowLongz = "00"+changedHowLong.toString();
      break;
    case 3:
      currentHowLongz = "0"+changedHowLong.toString();
      break;
    case 4:
      currentHowLongz = changedHowLong.toString();
      break;
  }
}
  Widget changeYearValue(String val, String hourMin, int increaseOrDecrease) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(hourMin),
          InkWell(
            onTap: () {
              if (val == '9') {
                print('ok');
              } else {
                setState(() {
                  changedHowLong = changedHowLong + increaseOrDecrease;
                  int digitLength= changedHowLong.toString().length;
                 changeToString(digitLength);
                });
              }
            },
            child: eachContainer('+', true),
          ),
          eachContainer("$val", false),
          InkWell(
              onTap: () {
                if(val=='0') {
                  print('ok');
                }else {
                  setState(() {
                    changedHowLong = changedHowLong - increaseOrDecrease;
                    int digitLength= changedHowLong.toString().length;
                    changeToString(digitLength);
                  });
                }
              },
              child: eachContainer("-", true))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    changedHowLong = widget.initialHowLong;
    changeToString(changedHowLong.toString().length);
  }

  int changedHowLong;
  String currentHowLongz;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                changeYearValue(currentHowLongz.substring(0, 1), "hh", 1000),
                changeYearValue(currentHowLongz.substring(1, 2), "hh", 100),
                changeYearValue(currentHowLongz.substring(2, 3), "mm", 10),
                changeYearValue(currentHowLongz.substring(3), "mm", 1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        widget.changed(changedHowLong);
                        Navigator.of(context).pop();
                      },
                      child: Text('change'),
                      color: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('cancel'),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
  }
}
