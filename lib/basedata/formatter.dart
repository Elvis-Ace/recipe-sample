import 'package:intl/intl.dart';
import 'dart:math';

class MyFormatter{
  static String formatNumber(String price){
    return (NumberFormat.decimalPattern('en_US').format(num.parse(price.replaceAll(',', '')))).toString();
  }

  String dateformater(DateTime dateTime) {
    String daySuffix = _getDaySuffix(dateTime.day);
    String month = _getMonthName(dateTime.month);
    return '${dateTime.day}$daySuffix $month ${dateTime.year}';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    } else {
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }



  static String IdGenerator(int number){
    return number.toString().padLeft(6, '0');
  }

  static int randomid(){
    var rndnumber="";
    var rnd= new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    return int.parse(rndnumber);
  }

  static String mydateformat(DateTime datetime){
    final f = DateFormat('dd-MM-yyyy hh:mm');

    return f.format(datetime);
  }
}