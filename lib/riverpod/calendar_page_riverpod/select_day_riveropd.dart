import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectDayInfoProvider extends StateNotifier<DateTime> {
  SelectDayInfoProvider() : super(DateTime.now());

  void setDay(DateTime value) {
    state = value;
  }
}

final selectDayStateNotifierProvider =
    StateNotifierProvider<SelectDayInfoProvider, DateTime>((ref) {
  return SelectDayInfoProvider();
});
