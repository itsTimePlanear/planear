import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';

class AvatarWearing extends StateNotifier<AvatarItemState> {
  AvatarWearing() : super(nothing);
  void setAvatar(AvatarItemState value) {
    final newState = AvatarItemState(
        accessory: value.accessory,
        body: value.body,
        etc: value.etc,
        face: value.face,
        lower_hair: value.lower_hair,
        pants: value.pants,
        shoes: value.shoes,
        top: value.top,
        upper_hair: value.upper_hair);
    state = newState;
  }
}

final avatarWearingStateNotifierProvider =
    StateNotifierProvider<AvatarWearing, AvatarItemState>((ref) {
  return AvatarWearing();
});
