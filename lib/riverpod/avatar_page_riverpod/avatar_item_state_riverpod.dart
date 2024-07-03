import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LookingAvatarState {
  face('얼굴', 1),
  hair('헤어', 2),
  top('상의', 3),
  pants('하의', 4),
  shoes('신발', 5),
  accessory('acc', 6),
  etc('기타', 7);

  const LookingAvatarState(this.name, this.num);
  final String name;
  final int num;
}

class LookingAvatarItem extends StateNotifier<LookingAvatarState> {
  LookingAvatarItem() : super(LookingAvatarState.face);
  void setState(LookingAvatarState value) {
    state = value;
  }
}

final lookingAvatarItemStateNotifierProvider =
    StateNotifierProvider<LookingAvatarItem, LookingAvatarState>((ref) {
  return LookingAvatarItem();
});
