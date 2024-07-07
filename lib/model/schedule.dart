import 'package:planear/utils/date_utils.dart';

class Schedule {
  int id;
  int categoryId = 5;
  String? title;
  DateTime start;
  DateTime end;
  bool finish = false;
  String detail = '';
  Schedule(
      {required this.id,
      required this.start,
      required this.end,
      required this.title,
      required this.categoryId,
      required this.finish,
      text});
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      categoryId: json['categoryId'],
      title: json['title'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      finish: json['completion'],
      text: json['text'] ?? '',
    );
  }
  factory Schedule.copy(Schedule schedule) {
    return Schedule(
        id: schedule.id,
        start: schedule.start,
        end: schedule.end,
        title: schedule.title,
        categoryId: schedule.categoryId,
        finish: schedule.finish);
  }
}

Map<String, dynamic> scheduleToJson(Schedule schedule) {
  return <String, dynamic>{
    "title": schedule.title,
    "start": dateTimeToString(schedule.start),
    "end": dateTimeToString(schedule.end),
    "categoryId": schedule.categoryId,
    "detail": schedule.detail
  };
}

Schedule scheduleDummy = Schedule(
    id: 0,
    categoryId: 6,
    title: '',
    start: DateTime.now(),
    end: DateTime.now(),
    finish: false);
