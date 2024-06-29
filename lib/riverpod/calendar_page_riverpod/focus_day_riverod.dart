import 'package:flutter_riverpod/flutter_riverpod.dart';

class FocusDayInfoProvider extends StateNotifier<DateTime> {
  FocusDayInfoProvider() : super(DateTime.now());

  void setDay(DateTime value) {
    state = value;
  }
}

final focusDayStateNotifierProvider =
    StateNotifierProvider<FocusDayInfoProvider, DateTime>((ref) {
  return FocusDayInfoProvider();
});
