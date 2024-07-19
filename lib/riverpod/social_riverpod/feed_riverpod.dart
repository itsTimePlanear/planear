import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/feed.dart';

class FeedState extends StateNotifier<Feed>{
  FeedState() : super(Feed(nickname: "", items: [], uncomplete: Uncomplete(achievementRate: 0, uncompleteCount: 0), todaySchedule: [],qna : Qna(question: '', answer: '') ));

  void setFeedNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void setAchievement(Uncomplete? uncomplete) {
    if (uncomplete != null) {
      state = state.copyWith(
        uncomplete: state.uncomplete!.copyWith(
          uncompleteCount: uncomplete.uncompleteCount,
          achievementRate: uncomplete.achievementRate,
        ),
      );
    } else {
      state = state.copyWith(
        uncomplete: Uncomplete(achievementRate: 0, uncompleteCount: 0),
      );
    }
  }

  void setListEmpty(){
    state.items = [];
    state.todaySchedule = [];
  }

  void addSchedules(List<TodaySchedule> items) {
  if (items.isNotEmpty) {
    List<TodaySchedule> updatedSchedules = List.from(state.todaySchedule ?? []);
    updatedSchedules.addAll(items);
    state = state.copyWith(todaySchedule: updatedSchedules);
  }
}

  void setQna(Qna? qna){
    if(qna != null){
      state = state.copyWith(
        qna: state.qna!.copyWith(
          question: qna.question,
          answer: qna.answer
        )
      );
    }
  }
}

final feedNotifierProvider = 
StateNotifierProvider<FeedState, Feed>((ref){
  return FeedState();
});
