import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';

class AvatarWearing extends StateNotifier<AvatarItemState> {
  AvatarWearing() : super(AvatarItemState());
  void setAvatar(AvatarItemState value) {
    final newState = AvatarItemState(
        accessory: value.accessory,
        etc: value.etc,
        face: value.face,
        hair: value.hair,
        pants: value.pants,
        shoes: value.shoes,
        top: value.top);
    state = newState;
  }
}

final avatarWearingStateNotifierProvider =
    StateNotifierProvider<AvatarWearing, AvatarItemState>((ref) {
  return AvatarWearing();
});
