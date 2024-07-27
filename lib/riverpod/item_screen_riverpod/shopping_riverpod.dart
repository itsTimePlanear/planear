import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/model/item.dart';

class AvatarShopping extends StateNotifier<AvatarItemState> {
  AvatarShopping() : super(AvatarItemState());
  void setAvatar(AvatarItemState item) {
    state = item;
  }

  void setFace(Item item) {
    final Item? face = (item.id == state.face?.id) ? null : item;

    AvatarItemState newState = AvatarItemState(
        hair: state.hair,
        face: face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setHair(Item item) {
    final Item? hair = (item.id == state.hair?.id) ? null : item;
    AvatarItemState newState = AvatarItemState(
        hair: hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setTop(Item item) {
    final Item? top = (item.id == state.top?.id) ? null : item;

    AvatarItemState newState = AvatarItemState(
        hair: state.hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setPants(Item item) {
    final Item? pants = (item.id == state.pants?.id) ? null : item;

    AvatarItemState newState = AvatarItemState(
        hair: state.hair,
        face: state.face,
        pants: pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setShoes(Item item) {
    final Item? shoes = (item.id == state.shoes?.id) ? null : item;

    AvatarItemState newState = AvatarItemState(
        hair: state.hair,
        face: state.face,
        pants: state.pants,
        shoes: shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setAcc(Item item) {
    final Item? accessory = (item.id == state.accessory?.id) ? null : item;
    AvatarItemState newState = AvatarItemState(
        hair: state.hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: accessory,
        etc: state.etc);
    state = newState;
  }

  void setEtc(Item item) {
    final Item? etc = (item.id == state.etc?.id) ? null : item;
    AvatarItemState newState = AvatarItemState(
        hair: state.hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: etc);
    state = newState;
  }

  void copy(AvatarItemState value) {
    AvatarItemState newState = AvatarItemState(
      accessory: value.accessory,
      etc: value.etc,
      face: value.face,
      hair: value.hair,
      pants: value.pants,
      shoes: value.shoes,
      top: value.top,
    );
    state = newState;
  }
}

final avatarShoppingStateNotifierProvider =
    StateNotifierProvider<AvatarShopping, AvatarItemState>((ref) {
  return AvatarShopping();
});
