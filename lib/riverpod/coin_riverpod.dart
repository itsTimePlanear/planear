import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinChange extends StateNotifier<int> {
  CoinChange() : super(0);

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
    StateNotifierProvider<CoinChange, int>((ref) {
  return CoinChange();
});
