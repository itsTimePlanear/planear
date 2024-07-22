import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/status.dart';

class StatusType extends StateNotifier<String> {
  StatusType() : super('');

  void setStatus(String value) {
    state = value;
  }
}

final statusTypeNotifierProvider =
    StateNotifierProvider<StatusType, String>((ref) {
  return StatusType();
});

class StatusAchievement extends StateNotifier<Uncomplete> {
  StatusAchievement()
      : super(Uncomplete(achievementRate: 0, uncompleteCount: 0));

  void setAchievement(Uncomplete uncomplete) {
    state.uncompleteCount = uncomplete.uncompleteCount;
    state.achievementRate = uncomplete.achievementRate;
  }
}

final statusAchievementNotifierProvider =
    StateNotifierProvider<StatusAchievement, Uncomplete>((ref) {
  return StatusAchievement();
});

class StatusTodaySchedule extends StateNotifier<List<TodaySchedule>> {
  StatusTodaySchedule() : super([]);

  Future<void> setEmpty() async {
    state = [];
  }

  void addSchedules(List<TodaySchedule> items) {
    for (var item in items) {
      state.add(item);
    }
  }
}

final todayScheduleStateNotifierProvider =
    StateNotifierProvider<StatusTodaySchedule, List<TodaySchedule>>((ref) {
  return StatusTodaySchedule();
});

class StatusQna extends StateNotifier<Qna> {
  StatusQna() : super(Qna(question: '', answer: ''));

  void setQna(Qna qna) {
    state.question = qna.question;
    state.answer = qna.answer;
  }
}

final statusQnaNotifierProvider = StateNotifierProvider<StatusQna, Qna>((ref) {
  return StatusQna();
});
