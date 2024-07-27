import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleModalProvider extends StateNotifier<bool> {
  ScheduleModalProvider() : super(false);

  void setTrue() {
    state = true;
  }

  void setFalse() {
    state = false;
  }
}

final scheduleModalNotifierProvider =
    StateNotifierProvider<ScheduleModalProvider, bool>((ref) {
  return ScheduleModalProvider();
});
