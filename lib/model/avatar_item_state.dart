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

  factory AvatarItemState.fromJsonList(List<Map<String, dynamic>> list) {
    Item? hair;
    Item? face;
    Item? pants;
    Item? shoes;
    Item? top;
    Item? accessory;
    Item? etc;
    for (Map<String, dynamic> json in list) {
      Item item = Item.wearingFromJson(json);
      if (item.category == 1) {
        hair = item;
      } else if (item.category == 2) {
        face = item;
      } else if (item.category == 3) {
        pants = item;
      } else if (item.category == 4) {
        shoes = item;
      } else if (item.category == 5) {
        top = item;
      } else if (item.category == 6) {
        accessory = item;
      } else if (item.category == 7) {
        etc = item;
      }
    }
    return AvatarItemState(
        hair: hair,
        face: face,
        pants: pants,
        shoes: shoes,
        top: top,
        accessory: accessory,
        etc: etc);
  }
}
