import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/friend.dart';

class FriendAvatar extends StateNotifier<List<Friend>>{
  FriendAvatar() : super([]);

  void setEmpty() {
    state = [];
  }

  void addFriendInfos(List<Friend> items){
    for(var item in items){
      state.add(item);
    }
  }
}

final friendStateNotifierProvider = 
StateNotifierProvider<FriendAvatar, List<Friend>>((ref){
  return FriendAvatar();
});