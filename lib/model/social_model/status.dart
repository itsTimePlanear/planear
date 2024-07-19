class Uncomplete{
  late int uncompleteCount;
  late int achievementRate;
  Uncomplete({
    required this.achievementRate,
    required this.uncompleteCount
  });

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

	Qna.fromJson(Map<String, dynamic> json) {
		question = json['question'];
		answer = json['answer'];
	}
}