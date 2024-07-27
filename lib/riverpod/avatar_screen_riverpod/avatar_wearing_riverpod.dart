import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/repository/avatar_screen/avatar_wearing_repo.dart';
import 'package:planear/utils/item_utils.dart';

class AvatarWearing extends StateNotifier<AvatarItemState> {
  AvatarWearing() : super(AvatarItemState());
  void setAvatar(AvatarItemState value) {
    final newState = AvatarItemState(
        accessory: setBuy(value.accessory),
        etc: setBuy(value.etc),
        face: setBuy(value.face),
        hair: setBuy(value.hair),
        pants: setBuy(value.pants),
        shoes: setBuy(value.shoes),
        top: setBuy(value.top));
    state = newState;
    debugPrint('아바타 설정');
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
