import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameChange extends StateNotifier<String> {
  NameChange() : super('');

  void setName(String value) {
    state = value;
  }
}

final nameChangeStateNotifierProvider =
    StateNotifierProvider<NameChange, String>((ref) {
  return NameChange();
});
