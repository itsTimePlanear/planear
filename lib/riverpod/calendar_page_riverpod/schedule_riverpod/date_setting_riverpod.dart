import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DateSettings { start, end }

class DateSettingProvider extends StateNotifier<DateSettings?> {
  DateSettingProvider() : super(null);

  void setStart() {
    state = DateSettings.start;
  }

  void setEnd() {
    state = DateSettings.end;
  }

  void setNull() {
    state = null;
  }
}

final dateSettingNotifierProvider =
    StateNotifierProvider<DateSettingProvider, DateSettings?>((ref) {
  return DateSettingProvider();
});
