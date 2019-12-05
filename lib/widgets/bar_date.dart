import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class BarDate extends StatefulWidget {
  final OnSelectCallback callBack;
  final String minDate;

  BarDate({
    this.callBack,
    this.minDate,
    Key key,
    }) : super(key: key);  

  @override
  _BarDateState createState() => _BarDateState();
}

class _BarDateState extends State<BarDate> {
  String nameMonth = "";
  int day = 0;
  int month = 0;
  int year = 0;

  int monthMax = 0;
  int yearMax = 0;
  int monthMin = 0;
  int yearMin = 0;
  bool backDisabled = false;
  bool nextDisabled = false;

  @override
  void initState() {
    final time = DateTime.now();
    final minDate = DateFormat("yyyy-MM-dd").parse(widget.minDate);
    day = time.day;
    month = time.month;
    year = time.year;
    nameMonth = DateFormat.MMMM("es_PE").format(new DateTime(year, month, day));

    monthMax = time.month;
    yearMax = time.year;

    monthMin = minDate.month;
    yearMin = minDate.year;
    backDisabled = (year == yearMin && month == monthMin);
    nextDisabled = (year == yearMax && month == monthMax);
    super.initState();
  }

// es_PE;
  @override
  Widget build(BuildContext context) {    
    return Container(
      width: double.infinity,
      height: 47.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => backDisabled ? {} : _setN(),
            padding: EdgeInsets.fromLTRB(32.0, 8.0, 8.0, 8.0),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16.0,
              color: backDisabled ? Colors.white : Colors.grey,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "$nameMonth".toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => nextDisabled ? {} : _setP(),
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 32.0, 8.0),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
              color: nextDisabled ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _c(bool pOn) {
    switch (month) {
      case 1:{
        month = pOn ? 2 : 12;
        year =  pOn ? year : (year - 1);
        }
      break;
      case 2:{
        month = pOn ? 3 : 1;
        }
      break;
      case 3:{
        month = pOn ? 4 : 2;
        }
      break;
      case 4:{
        month = pOn ? 5 : 3;
        }
      break;
      case 5:{
        month = pOn ? 6 : 4;
        }
      break;
      case 6:{
        month = pOn ? 7 : 5;
        }
      break;
      case 7:{
        month = pOn ? 8 : 6;
        }
      break;
      case 8:{
        month = pOn ? 9 : 7;
        }
      break;
      case 9:{
        month = pOn ? 10 : 8;
        }
      break;
      case 10:{
        month = pOn ? 11 : 9;
        }
      break;
      case 11:{
        month = pOn ? 12 : 10;
        }
      break;
      case 12:{
        month = pOn ? 1 : 11;
        year =  pOn ? (year + 1) : year;
        }
      break;
      default:
    }

    setState(() {
      backDisabled = (year == yearMin && month == monthMin);
      nextDisabled = (year == yearMax && month == monthMax);
      nameMonth = DateFormat.MMMM("es_PE").format(new DateTime(year, month, day));
    });

    widget.callBack("$year-${month >= 10 ? month: "0$month"}-$day");
  }

  _setP() {
    _c(true);
  }

  _setN() {
    _c(false);
  }
}

typedef OnSelectCallback = void Function(String format);