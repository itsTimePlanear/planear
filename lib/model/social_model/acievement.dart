import 'package:planear/model/social_model/feed.dart';

class Achievement{
  late String nickname;
  List<ItemsAcievement>? items;
  UncompleteAchievement? uncomplete;
  Achievement({
    required this.nickname,
    this.items,
    this.uncomplete
  });
  Achievement copyWith({
    String? nickname,
    List<ItemsAcievement>? items,
    UncompleteAchievement? uncomplete,
  }
  ){
    return Achievement(
      nickname: nickname ?? this.nickname,
      items: items ?? this.items,
      uncomplete: uncomplete ?? this.uncomplete,
    );
  }
}

class UncompleteAchievement{
  late int todayScheduleCount;
  late int achievementRate;
  UncompleteAchievement({
    required this.achievementRate,
    required this.todayScheduleCount
  });

  UncompleteAchievement copyWith({int? todayScheduleCount, int? achievementRate}) {
    return UncompleteAchievement(
      todayScheduleCount: todayScheduleCount ?? this.todayScheduleCount,
      achievementRate: achievementRate ?? this.achievementRate,
    );
  }

  factory UncompleteAchievement.uncompleteFromJson(Map<String, dynamic> json){
    return UncompleteAchievement(
      achievementRate: json['achievementRate'], 
      todayScheduleCount: json['todayScheduleCount']);
  }
}

class ItemsAcievement {
	int? id;
	String? urlShop;
	String? urlAvatar1;
	String? urlAvatar2;
	String? bodyPart;

	ItemsAcievement({this.id, this.urlShop, this.urlAvatar1, this.urlAvatar2, this.bodyPart});

	ItemsAcievement.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		urlShop = json['url_shop'];
		urlAvatar1 = json['url_avatar1'];
		urlAvatar2 = json['url_avatar2'];
		bodyPart = json['bodyPart'];
	}

}