class Questions{
  late String question;
  late int id;
  Questions({
    required this.question,
    required this.id
  });

  factory Questions.questionFromJson(Map<String, dynamic> json){
    return Questions(
      question: json['content'],
      id:json['id']
    );
  }

  @override
  String toString() {
    return 'Questions{id: $id, question: $question}';
  }
}