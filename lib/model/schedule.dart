class Schedule {
  String id;
  String name;
  DateTime date;
  String color = '0xff000000';
  bool finish = false;
  String text = '';
  Schedule(
      {required this.id,
      required this.date,
      required this.name,
      color,
      finish,
      text}) {
    // this.id = id;
    // this.name = name;
    this.color = color ?? this.color;
    this.finish = finish ?? this.finish;
    this.text = text ?? this.text;
  }
}
