import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/repository/avatar_screen/avatar_wearing_repo.dart';

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

  Future<void> setAvatarFromJson(int id) async {
    List<Map<String, dynamic>>? jsonList = await getWearingItems(id);
    if (jsonList != null) {
      state = AvatarItemState.fromJsonList(jsonList);
    }
  }
}

final avatarWearingProvider =
    StateNotifierProvider<AvatarWearing, AvatarItemState>((ref) {
  return AvatarWearing();
});
