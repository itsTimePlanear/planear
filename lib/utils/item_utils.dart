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
  return null;
}

List<Item> noneItems(AvatarItemState state) {
  List<Item> items = [];
  if (state.accessory?.has == false) {
    items.add(state.accessory!);
  }
  if (state.etc?.has == false) {
    items.add(state.etc!);
  }
  if (state.face?.has == false) {
    items.add(state.face!);
  }
  if (state.hair?.has == false) {
    items.add(state.hair!);
  }
  if (state.pants?.has == false) {
    items.add(state.pants!);
  }
  if (state.shoes?.has == false) {
    items.add(state.shoes!);
  }
  if (state.top?.has == false) {
    items.add(state.top!);
  }
  return items;
}

List<Item> shoppingToList(AvatarItemState state) {
  List<Item> items = [];
  if (state.accessory?.has != null) {
    items.add(state.accessory!);
  }
  if (state.etc?.has != null) {
    items.add(state.etc!);
  }
  if (state.face?.has != null) {
    items.add(state.face!);
  }
  if (state.hair?.has != null) {
    items.add(state.hair!);
  }
  if (state.pants?.has != null) {
    items.add(state.pants!);
  }
  if (state.shoes?.has != null) {
    items.add(state.shoes!);
  }
  if (state.top?.has != null) {
    items.add(state.top!);
  }
  return items;
}
