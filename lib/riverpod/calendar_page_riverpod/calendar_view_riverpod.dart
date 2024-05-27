import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewProvider extends StateNotifier<CalendarFormat> {
  CalendarViewProvider() : super(CalendarFormat.month);

  void setState(CalendarFormat value) {
    state = value;
  }
}

final claendarViewNotifierProvider =
    StateNotifierProvider<CalendarViewProvider, CalendarFormat>((ref) {
  return CalendarViewProvider();
});
