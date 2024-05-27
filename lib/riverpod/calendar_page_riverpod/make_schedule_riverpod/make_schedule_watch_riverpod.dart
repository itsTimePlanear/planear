import 'package:flutter_riverpod/flutter_riverpod.dart';

class MakeScheduleWatchProvider extends StateNotifier<bool> {
  MakeScheduleWatchProvider() : super(false);

  void setTrue() {
    state = true;
  }

  void setFalse() {
    state = false;
  }
}

final makeScheduleWatchNotifierProvider =
    StateNotifierProvider<MakeScheduleWatchProvider, bool>((ref) {
  return MakeScheduleWatchProvider();
});
