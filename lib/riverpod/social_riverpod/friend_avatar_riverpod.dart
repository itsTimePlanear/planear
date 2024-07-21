import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/acievement.dart';
import 'package:planear/utils/item_utils.dart';

class FriendAvatarWearing extends StateNotifier<ItemsAcievement>{
  FriendAvatarWearing() : super(ItemsAcievement());
  void setFriendAvatar(ItemsAcievement value){
    final newState = ItemsAcievement(
      accessory: setBuy(value.accessory),
        etc: setBuy(value.etc),
        face: setBuy(value.face),
        hair: setBuy(value.hair),
        pants: setBuy(value.pants),
        shoes: setBuy(value.shoes),
        top: setBuy(value.top) );
        state = newState;
        debugPrint('친구아바타 설정');
  }
}

final friendAvatarWearingProvider = 
StateNotifierProvider<FriendAvatarWearing, ItemsAcievement>((ref){
  return FriendAvatarWearing();
});