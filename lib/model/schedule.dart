class Schedule {
  int id;
  int categoryId = 5;
  String? title;
  DateTime start;
  DateTime end;
  bool finish = false;
  String text = '';
  Schedule(
      {required this.id,
      required this.start,
      required this.end,
      required this.title,
      required this.categoryId,
      finish,
      String? color,
      text}) {
    // this.id = id;
    title = title;
    this.finish = finish ?? this.finish;
    this.text = text ?? this.text;
  }
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      categoryId: json['categoryId'],
      title: json['name'] ?? '',
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      finish: json['completion'] ?? false,
      text: json['text'] ?? '',
    );
  }
  factory Schedule.copy(Schedule schedule) {
    return Schedule(
        id: schedule.id,
        start: schedule.start,
        end: schedule.end,
        title: schedule.title,
        categoryId: schedule.categoryId);
  }
}

Schedule scheduleDummy = Schedule(
    id: 0,
    categoryId: 6,
    title: '',
    start: DateTime.now(),
    end: DateTime.now());
