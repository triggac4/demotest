import 'package:flutter/material.dart';
class SelectYear extends StatefulWidget {
  SelectYear(this.currentYear,this.changeYear);
 final int currentYear;
 final Function(int) changeYear;
  @override
  _SelectYearState createState() => _SelectYearState();
}

class _SelectYearState extends State<SelectYear> {

  Widget eachContainer(String val,bool border){
    return Container(
      decoration: BoxDecoration(
          border:border? Border.all(color: Colors.black):null,
          borderRadius: BorderRadius.circular(10)
      ),
      constraints: BoxConstraints(minHeight: 30,minWidth: 30),
      alignment: Alignment.center,
      child: Text('$val',style:TextStyle(
        fontSize: 25,
      )),
    );
  }
  Widget changeYearValue(String val,int increaseOrDecrease){
  return Padding(
    padding:EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: (){
              if(val=='9'){
                print('ok');
              }else{
              setState(() {
                currentYear=currentYear+increaseOrDecrease;
              });}
            },
            child: eachContainer('+',true),),
        eachContainer("$val",false),
        InkWell(
            onTap: (){
              if(val=='1'&& increaseOrDecrease==1000|| (val=='0'&&increaseOrDecrease!=1000)){
                print('ok');
              }else {
                setState(() {
                  currentYear = currentYear - increaseOrDecrease;
                });
              }
            },
            child:eachContainer("-",true))
      ],
    ),
  );
}
@override
  void initState() {
    super.initState();
    currentYear=widget.currentYear;
  }
int currentYear;
  @override
  Widget build(BuildContext context) {

var currentYearz=currentYear.toString();
    return SimpleDialog(

shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10)
),
        children:[ Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              changeYearValue(currentYearz.substring(0,1),1000),
              changeYearValue(currentYearz.substring(1,2),100),
              changeYearValue(currentYearz.substring(2,3),10),
              changeYearValue(currentYearz.substring(3),1),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(onPressed: (){
                    widget.changeYear(currentYear);
                    Navigator.of(context).pop();
                  }, child: Text('change'),
                  color: Theme.of(context).primaryColor,
                  ),
                  FlatButton(onPressed: ()=>
                    Navigator.of(context).pop()
                  , child: Text('cancel'),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),

        ),]
      );
  }
}
