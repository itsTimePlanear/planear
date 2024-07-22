import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashFocusChange extends StateNotifier<bool> {
  SplashFocusChange() : super(false);
  setTrue() {
    state = true;
  }

  setFalse() {
    state = false;
  }
}

final nameFocusProvider = StateNotifierProvider<SplashFocusChange, bool>((ref) {
  return SplashFocusChange();
});

class SplashNameCheck extends StateNotifier<bool> {
  SplashNameCheck() : super(false);
  setTrue() {
    state = true;
  }

  setFalse() {
    state = false;
  }
}

final nameDuplicationProvider = StateNotifierProvider<SplashNameCheck, bool>((ref) {
  return SplashNameCheck();
});
