import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planear/model/make_schedule.dart';

class MakeScheduleProvider extends StateNotifier<NewSchedule> {
  MakeScheduleProvider()
      : super(NewSchedule(
            id: '0',
            name: '',
            startDate: DateTime.now(),
            endDate: DateTime.now()));

  void setSchedule(NewSchedule value) {
    NewSchedule newSchedule = NewSchedule(
        id: value.id,
        name: value.name,
        startDate: value.startDate,
        endDate: value.endDate,
        color: value.color,
        text: value.text);
    state = newSchedule;
  }

  void setName(String name) {
    NewSchedule newSchedule = NewSchedule(
        id: state.id,
        name: name,
        startDate: state.startDate,
        endDate: state.endDate,
        color: state.color,
        text: state.text);
    state = newSchedule;
  }

  void setColor(String color) {
    NewSchedule newSchedule = NewSchedule(
        id: state.id,
        name: state.name,
        color: color,
        startDate: state.startDate,
        endDate: state.endDate,
        text: state.text);
    state = newSchedule;
  }

  void setStart(DateTime start) {
    NewSchedule newSchedule = NewSchedule(
        id: state.id,
        name: state.name,
        startDate: start,
        endDate: state.endDate,
        color: state.color,
        text: state.text);
    state = newSchedule;
  }

  void setEnd(DateTime end) {
    NewSchedule newSchedule = NewSchedule(
        id: state.id,
        name: state.name,
        startDate: state.startDate,
        endDate: end,
        color: state.color,
        text: state.text);
    state = newSchedule;
  }

  void setText(String text) {
    NewSchedule newSchedule = NewSchedule(
        id: state.id,
        name: state.name,
        startDate: state.startDate,
        endDate: state.endDate,
        color: state.color,
        text: text);
    state = newSchedule;
  }
}

final makeScheduleStateNotifierProvider =
    StateNotifierProvider<MakeScheduleProvider, NewSchedule>((ref) {
  return MakeScheduleProvider();
});
