import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planear/model/schedule.dart';

class MakeScheduleProvider extends StateNotifier<Schedule> {
  MakeScheduleProvider()
      : super(Schedule(
            id: '0', name: '', start: DateTime.now(), end: DateTime.now()));

  void setSchedule(Schedule value) {
    Schedule newSchedule = Schedule(
        id: value.id,
        name: value.name,
        start: value.start,
        end: value.endDate,
        color: value.color,
        text: value.text);
    state = newSchedule;
  }

  void setName(String name) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: name,
        start: state.start,
        end: state.endDate,
        color: state.color,
        text: state.text);
    state = newSchedule;
  }

  void setColor(String color) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        color: color,
        start: state.start,
        end: state.endDate,
        text: state.text);
    state = newSchedule;
  }

  void setStart(DateTime start) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        start: start,
        end: state.endDate,
        color: state.color,
        text: state.text);
    state = newSchedule;
  }

  void setEnd(DateTime end) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        start: state.start,
        end: end,
        color: state.color,
        text: state.text);
    state = newSchedule;
  }

  void setText(String text) {
    Schedule newSchedule = Schedule(
        id: state.id,
        name: state.name,
        start: state.start,
        end: state.endDate,
        color: state.color,
        text: text);
    state = newSchedule;
  }
}

final makeScheduleStateNotifierProvider =
    StateNotifierProvider<MakeScheduleProvider, Schedule>((ref) {
  return MakeScheduleProvider();
});
