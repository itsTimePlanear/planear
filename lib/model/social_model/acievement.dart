import 'dart:convert';

import 'package:planear/model/item.dart';
import 'package:planear/model/social_model/feed.dart';

class Achievement{
  late String nickname;
  List<ItemsAcievement>? items;
  int? achievementRate;
  int? todayScheduleCount;
  Achievement({
    required this.nickname,
    this.items,
    this.achievementRate,
    this.todayScheduleCount
  });
  Achievement copyWith({
    String? nickname,
    List<ItemsAcievement>? items,
    int? achievementRate,
    int? todayScheduleCount
  }
  ){
    return Achievement(
      nickname: nickname ?? this.nickname,
      items: items ?? this.items,
      achievementRate: achievementRate ?? this.achievementRate,
      todayScheduleCount: todayScheduleCount ?? this.todayScheduleCount
    );
  }
}

class ItemsAcievement {
  Item? hair;
  Item? face;
  Item? pants;
  Item? shoes;
  Item? top;
  Item? accessory;
  Item? etc;
  ItemsAcievement(
      {this.hair,
      this.face,
      this.pants,
      this.shoes,
      this.top,
      this.accessory,
      this.etc});

  factory ItemsAcievement.copy(ItemsAcievement items) {
    return ItemsAcievement(
        hair: items.hair,
        face: items.face,
        pants: items.pants,
        shoes: items.shoes,
        top: items.top,
        accessory: items.accessory,
        etc: items.etc);
  }

  factory ItemsAcievement.fromJson(List<dynamic> jsonList) {
    Item? face;
    Item? hair;
    Item? pants;
    Item? shoes;
    Item? top;
    Item? accessory;
    Item? etc;
    
    for(var json in jsonList){
      Item item = Item.wearingFromJson(json);
      if (item.category == 1) {
        face = item;
      } else if (item.category == 2) {
        hair = item;
      } else if (item.category == 3) {
        top = item;
      } else if (item.category == 4) {
        pants = item;
      } else if (item.category == 5) {
        shoes = item;
      } else if (item.category == 6) {
        accessory = item;
      } else if (item.category == 7) {
        etc = item;
      }
    }
    
    return ItemsAcievement(
        hair: hair,
        face: face,
        pants: pants,
        shoes: shoes,
        top: top,
        accessory: accessory,
        etc: etc);
  }

}