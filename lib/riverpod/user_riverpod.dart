import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameChange extends StateNotifier<String> {
  NameChange() : super('');

  void setName(String value) async {
    state = value;
  }
}

final nameChangeStateNotifierProvider =
    StateNotifierProvider<NameChange, String>((ref) {
  return NameChange();
});

class IdChange extends StateNotifier<int> {
  IdChange() : super(0);

  void setId(int value) async {
    state = value;
  }
}

final idChangeStateNotifierProvider =
    StateNotifierProvider<IdChange, int>((ref) {
  return IdChange();
});
