import 'package:planear/model/social_model/questions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class QuestionsMessage extends StateNotifier<List<Questions>>{
  QuestionsMessage() : super([]);

  void setEmpty() {
    state = [];
  }

  void addFriendInfos(List<Questions> items){
    for(var item in items){
      state.add(item);
    }
  }
}

final questionNotifierProvider = 
StateNotifierProvider<QuestionsMessage, List<Questions>>((ref){
  return QuestionsMessage();
});