import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/item_screen_riverpod/item_view_state_riverpod.dart';

Item? checkLooking(LookingAvatarState look, AvatarItemState shoppingState) {
  switch (look) {
    case LookingAvatarState.face:
      return shoppingState.face;
    case LookingAvatarState.hair:
      return shoppingState.hair;
    case LookingAvatarState.top:
      return shoppingState.top;
    case LookingAvatarState.pants:
      return shoppingState.pants;
    case LookingAvatarState.shoes:
      return shoppingState.shoes;
    case LookingAvatarState.accessory:
      return shoppingState.accessory;
    case LookingAvatarState.etc:
      return shoppingState.etc;

    default:
      null;
  }
}
