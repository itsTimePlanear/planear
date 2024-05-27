import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planear/model/schedule.dart';

class WatchingScheduleProvider extends StateNotifier<Schedule> {
  WatchingScheduleProvider()
      : super(Schedule(id: '0', name: '', date: DateTime.now()));

  void setSchedule(Schedule value) {
    Schedule newSchedule = Schedule(
        id: value.id,
        name: value.name,
        date: value.date,
        color: value.color,
        finish: value.finish,
        text: value.text);
    state = newSchedule;
  }

  void setName(String name) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: name,
        date: state.date,
        color: state.color,
        finish: state.finish,
        text: state.text);
    state = newSchedule;
  }

  void setColor(String color) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        color: color,
        date: state.date,
        finish: state.finish,
        text: state.text);
    state = newSchedule;
  }

  void setFinish(bool finish) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        date: state.date,
        color: state.color,
        finish: finish,
        text: state.text);
    state = newSchedule;
  }

  void setText(String text) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        date: state.date,
        color: state.color,
        finish: state.finish,
        text: text);
    state = newSchedule;
  }
}

final watchingScheduleStateNotifierProvider =
    StateNotifierProvider<WatchingScheduleProvider, Schedule>((ref) {
  return WatchingScheduleProvider();
});
