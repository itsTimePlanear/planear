import 'package:planear/model/schedule.dart';

String month_eng(int month_int) {
  String month = '';

  if (month_int == 1) {
    month = 'January';
  } else if (month_int == 2) {
    month = 'February';
  } else if (month_int == 3) {
    month = 'March';
  } else if (month_int == 4) {
    month = 'April';
  } else if (month_int == 5) {
    month = 'May';
  } else if (month_int == 6) {
    month = 'June';
  } else if (month_int == 7) {
    month = 'July';
  } else if (month_int == 8) {
    month = 'August';
  } else if (month_int == 9) {
    month = 'September';
  } else if (month_int == 10) {
    month = 'October';
  } else if (month_int == 11) {
    month = 'November';
  } else if (month_int == 12) {
    month = 'December';
  }
  return month;
}

String weekday_kor(int value) {
  String v = '';
  switch (value) {
    case 1:
      v = '월';
    case 2:
      v = '화';
    case 3:
      v = '수';
    case 4:
      v = '목';
    case 5:
      v = '금';
    case 6:
      v = '토';
    case 7:
      v = '일';
  }
  return v;
}

String dateTimeToString(DateTime time) {
  String year = time.year.toString();
  late String month;
  late String day;
  if (time.month < 10) {
    month = '0${time.month}';
  } else {
    month = time.month.toString();
  }
  if (time.day < 10) {
    day = '0${time.day}';
  } else {
    day = time.day.toString();
  }
  return '$year-$month-$day';
}

bool checkTime(Schedule schedule, DateTime time) {
  time = DateTime(time.year, time.month, time.day);
  if (((schedule.start.isBefore(time)) || (schedule.start == time)) &&
      (schedule.end.isAfter(time) || (schedule.end == time))) {
    return true;
  }
  return false;
}
