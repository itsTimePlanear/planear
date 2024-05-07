import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AvatarPageState {
  main,
  shop,
  myItem,
}

class AvatarPageChange extends StateNotifier<AvatarPageState> {
  AvatarPageChange() : super(AvatarPageState.main);
  void setPage(AvatarPageState value) {
    state = value;
  }
}

final avatarPageChangeStateNotifierProvider =
    StateNotifierProvider<AvatarPageChange, AvatarPageState>((ref) {
  return AvatarPageChange();
});
