import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinPageChange extends StateNotifier<int> {
  CoinPageChange() : super(0);

  void setCoin(int value) {
    state = value;
  }

  void addCoin(int value) {
    state = state + value;
  }

  void minusCoin(int value) {
    state = state - value;
  }
}

final coinChangeStateNotifierProvider =
    StateNotifierProvider<CoinPageChange, int>((ref) {
  return CoinPageChange();
});
