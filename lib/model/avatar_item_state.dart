import 'package:planear/model/item.dart';

class AvatarItemState {
  Item? hair;
  Item? face;
  Item? pants;
  Item? shoes;
  Item? top;
  Item? accessory;
  Item? etc;
  AvatarItemState(
      {this.hair,
      this.face,
      this.pants,
      this.shoes,
      this.top,
      this.accessory,
      this.etc});

  factory AvatarItemState.copy(AvatarItemState items) {
    return AvatarItemState(
        hair: items.hair,
        face: items.face,
        pants: items.pants,
        shoes: items.shoes,
        top: items.top,
        accessory: items.accessory,
        etc: items.etc);
  }
}

AvatarItemState defaultAvatar = AvatarItemState();

AvatarItemState nothing = AvatarItemState();
