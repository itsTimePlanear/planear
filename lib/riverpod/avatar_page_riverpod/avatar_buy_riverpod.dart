import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsBuy extends StateNotifier<bool> {
  IsBuy() : super(false);
  void setTrue() {
    state = true;
  }

  void setFalse() {
    state = false;
  }
}

final itemBuyStateNotifierProvider = StateNotifierProvider<IsBuy, bool>((ref) {
  return IsBuy();
});
