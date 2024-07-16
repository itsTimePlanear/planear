class Questions{
  late String question;
  Questions({
    required this.question
  });

  factory Questions.questionFromJson(Map<String, dynamic> json){
    return Questions(
      question: json['questions']);
  }
}