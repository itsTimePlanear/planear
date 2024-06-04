class Schedule {
  String id;
  String name;
  DateTime start;
  DateTime end;
  String color = '0xff000000';
  bool finish = false;
  String text = '';
  Schedule(
      {required this.id,
      required this.start,
      required this.end,
      required this.name,
      finish,
      String? color,
      text}) {
    // this.id = id;
    // this.name = name;
    this.color = color ?? this.color;
    this.finish = finish ?? this.finish;
    this.text = text ?? this.text;
  }
}
