class NewSchedule {
  String id;
  String name;
  DateTime startDate;
  DateTime endDate;
  String color = '0xff000000';
  bool finish = false;
  String text = '';
  NewSchedule(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.name,
      color,
      text}) {
    this.color = color ?? this.color;
    this.text = text ?? this.text;
  }
}
