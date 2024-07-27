import 'package:planear/model/item.dart';

class Feed{
  late String nickname;
  late String type;
  List<FeedItems>? items;
  Uncomplete? uncomplete;
	List<TodayScheduleFeed>? todaySchedule;
	Qna? qna;
  late String updateTime;
  Feed({
    required this.nickname,
    required this.type,
    this.items,
    this.qna,
    this.todaySchedule,
    this.uncomplete,
    required this.updateTime
  });
  Feed copyWith({
    String? nickname,
    String? type,
    List<FeedItems>? items,
    Uncomplete? uncomplete,
    List<TodayScheduleFeed>? todaySchedule,
    Qna? qna,
    String? updateTime
  }) {
    return Feed(
      nickname: nickname ?? this.nickname,
      type: type ?? this.type,
      items: items ?? this.items,
      uncomplete: uncomplete ?? this.uncomplete,
      todaySchedule: todaySchedule ?? this.todaySchedule,
      qna: qna ?? this.qna,
      updateTime: updateTime ?? this.updateTime
    );
  }
}

class FeedItems {
	Item? hair;
  Item? face;
  Item? pants;
  Item? shoes;
  Item? top;
  Item? accessory;
  Item? etc;
  FeedItems(
      {this.hair,
      this.face,
      this.pants,
      this.shoes,
      this.top,
      this.accessory,
      this.etc});

  factory FeedItems.copy(FeedItems items) {
    return FeedItems(
        hair: items.hair,
        face: items.face,
        pants: items.pants,
        shoes: items.shoes,
        top: items.top,
        accessory: items.accessory,
        etc: items.etc);
  }

  factory FeedItems.fromJson(List<dynamic> jsonList) {
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
    
    return FeedItems(
        hair: hair,
        face: face,
        pants: pants,
        shoes: shoes,
        top: top,
        accessory: accessory,
        etc: etc);
  }

}

class Uncomplete{
  late int uncompleteCount;
  late int achievementRate;
  Uncomplete({
    required this.achievementRate,
    required this.uncompleteCount
  });

  Uncomplete copyWith({int? uncompleteCount, int? achievementRate}) {
    return Uncomplete(
      uncompleteCount: uncompleteCount ?? this.uncompleteCount,
      achievementRate: achievementRate ?? this.achievementRate,
    );
  }

  factory Uncomplete.uncompleteFromJson(Map<String, dynamic> json){
    return Uncomplete(
      achievementRate: json['achievementRate'], 
      uncompleteCount: json['uncompleteCount']);
  }
}

class TodayScheduleFeed {
	String? title;
	bool? complete;

	TodayScheduleFeed({this.title, this.complete});

	TodayScheduleFeed.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		complete = json['complete'];
	}
}

class Qna {
	String? question;
	String? answer;

	Qna({this.question, this.answer});

  Qna copyWith({String? question, String? answer}){
    return Qna(
      question: question ?? this.question,
      answer: answer ?? this.answer
    );
  }

	Qna.fromJson(Map<String, dynamic> json) {
		question = json['question'];
		answer = json['answer'];
	}
}

