import 'package:flutter_riverpod/flutter_riverpod.dart';

// example
class MainPageChange extends StateNotifier<int> {
  MainPageChange() : super(0);

  void setPage(int value) {
    state = value;
  }
}

final mainPageChangeStateNotifierProvider =
    StateNotifierProvider<MainPageChange, int>((ref) {
  return MainPageChange();
});

