class Feed{
  late String nickname;
  late String type;
  List<Items>? items;
  Uncomplete? uncomplete;
	List<TodaySchedule>? todaySchedule;
	Qna? qna;
  Feed({
    required this.nickname,
    required this.type,
    this.items,
    this.qna,
    this.todaySchedule,
    this.uncomplete
  });
  Feed copyWith({
    String? nickname,
    String? type,
    List<Items>? items,
    Uncomplete? uncomplete,
    List<TodaySchedule>? todaySchedule,
    Qna? qna,
  }) {
    return Feed(
      nickname: nickname ?? this.nickname,
      type: type ?? this.type,
      items: items ?? this.items,
      uncomplete: uncomplete ?? this.uncomplete,
      todaySchedule: todaySchedule ?? this.todaySchedule,
      qna: qna ?? this.qna,
    );
  }
}

class Items {
	int? id;
	String? urlShop;
	String? urlAvatar1;
	String? urlAvatar2;
	String? bodyPart;

	Items({this.id, this.urlShop, this.urlAvatar1, this.urlAvatar2, this.bodyPart});

	Items.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		urlShop = json['url_shop'];
		urlAvatar1 = json['url_avatar1'];
		urlAvatar2 = json['url_avatar2'];
		bodyPart = json['bodyPart'];
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

class TodaySchedule {
	String? title;
	bool? complete;

	TodaySchedule({this.title, this.complete});

	TodaySchedule.fromJson(Map<String, dynamic> json) {
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