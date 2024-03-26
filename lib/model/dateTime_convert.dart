import 'package:intl/intl.dart';

// to convert date/time/day from the calender to string
class DateConverted{
  static String getDate(DateTime date){
    return DateFormat.yMd().format(date);
  }
  static String getDay(int day){
    switch(day) {
      case 1 : return 'Monday';
      case 2 : return 'Tuesday';
      case 3 : return 'Wednesday';
      case 4 : return 'Thursday';
      case 5 : return 'Friday';
      case 6 : return 'Saturday';
      case 7 : return 'Sunday';
     default: return 'Sunday';
    }
  }

  static String getTime(int time){
    switch(time){
      case 0 : return '9:00 Am';
      case 1 : return '10:00 Am';
      case 2 : return '11:00 Am';
      case 3 : return '12:00 Am';
      case 4 : return '13:00 Am';
      case 5 : return '14:00 Am';
      case 6 : return '15:00 Am';
      case 7 : return '16:00 Am';
      default : return '9:00 Am';
    }
  }
}