import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/avatar_root.dart';

enum LookingAvatarState {
  face('얼굴', '${AvatarRoot.face_root}face', 1),
  hair('헤어', '${AvatarRoot.hair_root}hair', 1),
  top('상의', '${AvatarRoot.top_root}top', 1),
  pants('하의', '${AvatarRoot.pants_root}pants', 1),
  shoes('신발', '${AvatarRoot.shoes_root}shoes', 1),
  accessory('acc', '${AvatarRoot.accessory_root}accessory', 0),
  etc('기타', '${AvatarRoot.etc_root}etc', 2);

  const LookingAvatarState(this.name, this.root, this.num);
  final String name;
  final String root;
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
