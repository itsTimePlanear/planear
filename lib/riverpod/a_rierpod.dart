import 'package:flutter_riverpod/flutter_riverpod.dart';

// example
class BottomChange extends StateNotifier<int> {
  BottomChange() : super(0);

  void setValue(int v) {
    state = v;
  }
}

final bottomChangeStateNotifierProvider =
    StateNotifierProvider<BottomChange, int>((ref) {
  return BottomChange();
});

class Example extends StateNotifier<String> {
  Example() : super('type');

  void set(String v) {
    state = v;
  }
}

final exampleStateNotifierProvider =
    StateNotifierProvider<Example, String>((ref) {
  return Example();
});
