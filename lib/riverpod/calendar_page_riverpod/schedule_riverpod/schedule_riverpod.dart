import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planear/model/schedule.dart';

class ScheduleProvider extends StateNotifier<Schedule> {
  ScheduleProvider() : super(scheduleDummy);

  void setSchedule(Schedule value) {
    Schedule newSchedule = Schedule(
        id: value.id,
        categoryId: value.categoryId,
        title: value.title,
        start: value.start,
        end: value.end,
        detail: value.detail,
        finish: value.finish);
    state = newSchedule;
  }

  Future<void> setId(int id) async {
    Schedule newSchedule = Schedule(
        id: id,
        start: state.start,
        end: state.end,
        title: state.title,
        categoryId: state.categoryId,
        finish: state.finish,
        detail: state.detail);
    state = newSchedule;
  }

  void setName(String title) {
    Schedule newSchedule = Schedule(
        id: state.id,
        categoryId: state.categoryId,
        title: title,
        start: state.start,
        end: state.end,
        detail: state.detail,
        finish: state.finish);
    state = newSchedule;
  }

  void setCategory(int categoryId) {
    Schedule newSchedule = Schedule(
        id: state.id,
        categoryId: categoryId,
        title: state.title,
        start: state.start,
        end: state.end,
        detail: state.detail,
        finish: state.finish);
    state = newSchedule;
  }

  void setStart(DateTime start) {
    Schedule newSchedule = Schedule(
        id: state.id,
        categoryId: state.categoryId,
        title: state.title,
        start: start,
        end: state.end,
        detail: state.detail,
        finish: state.finish);
    state = newSchedule;
  }

  void setEnd(DateTime end) {
    Schedule newSchedule = Schedule(
        id: state.id,
        categoryId: state.categoryId,
        title: state.title,
        start: state.start,
        end: end,
        detail: state.detail,
        finish: state.finish);
    state = newSchedule;
  }

  void setDetail(String detail) {
    Schedule newSchedule = Schedule(
        id: state.id,
        categoryId: state.categoryId,
        title: state.title,
        start: state.start,
        end: state.end,
        detail: detail,
        finish: state.finish);
    state = newSchedule;
  }
}

final scheduleStateNotifierProvider =
    StateNotifierProvider<ScheduleProvider, Schedule>((ref) {
  return ScheduleProvider();
});
