import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planear/model/schedule.dart';

class FullDayInfoProvider extends StateNotifier<List<Schedule>> {
  FullDayInfoProvider() : super([]);

  void setSchedule(List<Schedule> value) {
    state = value;
  }

  void addScheudle(List<Schedule> value) {
    state.addAll(value);
    state = state.toSet().toList();
  }
}

final fullDayStateNotifierProvider =
    StateNotifierProvider<FullDayInfoProvider, List<Schedule>>((ref) {
  return FullDayInfoProvider();
});
