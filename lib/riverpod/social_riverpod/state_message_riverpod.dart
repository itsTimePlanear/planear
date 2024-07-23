import 'package:hooks_riverpod/hooks_riverpod.dart';

class StateMessage extends StateNotifier<bool> {
  StateMessage() : super(false);

  void setTrue() {
    state = true;
  }

  void setFalse() {
    state = false;
  }
}

final stateMessageChangeProvider =
    StateNotifierProvider<StateMessage, bool>((ref) {
  return StateMessage();
});
