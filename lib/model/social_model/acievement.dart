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