import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/acievement.dart';

class AchievementState extends StateNotifier<List<Achievement>>{
  AchievementState() : super([]);

  void setAchievements(List<Achievement> achievements){
    state = achievements;
  }

  void setListEmpty() {
    state = [];
  }

  void addAchievement(Achievement achievement){
    state = [...state, achievement];
  }
}

final achievementNotifierProvider = StateNotifierProvider<AchievementState, List<Achievement>>((ref){
  return AchievementState();
});