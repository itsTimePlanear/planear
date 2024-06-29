import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planear/model/schedule.dart';

class WatchingScheduleProvider extends StateNotifier<Schedule> {
  WatchingScheduleProvider()
      : super(Schedule(
            id: '0', name: '', start: DateTime.now(), end: DateTime.now()));

  void setSchedule(Schedule value) {
    Schedule newSchedule = Schedule(
        id: value.id,
        name: value.name,
        start: value.start,
        end: value.end,
        color: value.color,
        finish: value.finish,
        text: value.text);
    state = newSchedule;
  }

  void setName(String name) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: name,
        start: state.start,
        end: state.end,
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
        start: state.start,
        end: state.end,
        finish: state.finish,
        text: state.text);
    state = newSchedule;
  }

  void setFinish(bool finish) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        start: state.start,
        end: state.end,
        color: state.color,
        finish: finish,
        text: state.text);
    state = newSchedule;
  }

  void setText(String text) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        start: state.start,
        end: state.end,
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
