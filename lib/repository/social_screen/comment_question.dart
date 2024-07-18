import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/questions.dart';
import 'package:planear/riverpod/social_riverpod/questions_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;


Future<bool> getQuestion(WidgetRef ref) async {
  debugPrint('getQuestion 호출됨');
  ref.read(questionNotifierProvider.notifier).setEmpty();
  
  final url = Uri.parse('${UrlRoot.root}/questions');
  final response = await http.get(url, headers: {'accept': '*/*'});

  debugPrint('응답 상태 코드: ${response.statusCode}');
  if (response.statusCode == 200) {
    debugPrint('질문 조회 성공');
    final jsonLists = jsonDecode(utf8.decode(response.bodyBytes));
    List<dynamic> jsonQuestions = jsonLists['success']['questions'];
    List<Questions> questions = [];
    for (var jsonQuestion in jsonQuestions) {
      questions.add(Questions.questionFromJson(jsonQuestion));
      
    }
    try {
      ref.read(questionNotifierProvider.notifier).addFriendInfos(questions);
      debugPrint(questions.toString());
      return true;
    } catch (e) {
      debugPrint('Provider 업데이트 중 오류 발생: $e');
      return false;
    }
  } else {
    debugPrint('질문 조회 실패: ${response.statusCode}');
    return false;
  }
}

Future<void>postQuestions(WidgetRef ref, String type, String answer, Questions question) async {
  debugPrint("postQuestion 호출");
  final url = Uri.parse('${UrlRoot.root}/status');
  final id = ref.watch(idChangeStateNotifierProvider);
  final response = await http.post(url,
  body: jsonEncode({
      'type': type,
      'qna': {
        'questionId': question.id,
        'answer': answer
      }
    }),
  headers: {'user-no': id.toString(), 'Content-Type': 'application/json'});

  if(response.statusCode == 200){
    debugPrint('질문 보내기 완료');

  } else if(response.statusCode == 400){
    debugPrint('질문 보내기 실패${response.body}');
  } else{
    debugPrint('친구 추가 api 에러${response.body}');
  }
}