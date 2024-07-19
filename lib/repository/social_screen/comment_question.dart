import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/questions.dart';
import 'package:planear/model/social_model/status.dart';
import 'package:planear/riverpod/social_riverpod/questions_riverpod.dart';
import 'package:planear/riverpod/social_riverpod/status_riverpod.dart';
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

Future<void>postQuestions(WidgetRef ref, String type, String answer, int question) async {
  debugPrint("postQuestion 호출");
  final url = Uri.parse('${UrlRoot.root}/status');
  final id = ref.watch(idChangeStateNotifierProvider);
  final response = await http.post(url,
  body: jsonEncode({
      'type': type,
      'qna': {
        'questionId': question,
        'answer': answer
      }
    }),
  headers: {'user-no': id.toString(), 'Content-Type': 'application/json'});

  if(response.statusCode == 200){
    debugPrint('질문 보내기 완료');

  } else if(response.statusCode == 400){
    debugPrint('질문 보내기 실패${response.body}');
  } else{
    debugPrint('질문 보내기 api 에러${response.body}');
  }
}

Future<void> getStatus(WidgetRef ref) async {
  debugPrint('getstatus');
  ref.read(todayScheduleStateNotifierProvider.notifier).setEmpty();
  final url = Uri.parse('${UrlRoot.root}/status');
  int id = ref.watch(idChangeStateNotifierProvider);
  final response = await http.get(url, headers: {'user-no': id.toString()});

  if (response.statusCode == 200) {
    debugPrint('상태메세지 get 성공');
    final jsonLists = jsonDecode(response.body);

    if (jsonLists['success'] != null) {
      String type = jsonLists['success']['type'] ?? '';
      ref.read(statusTypeNotifierProvider.notifier).setStatus(type);

      // 'uncomplete' 키가 null인 경우를 허용
      Map<String, dynamic>? jsonStatusAchievement = jsonLists['success']['uncomplete'];
      if (jsonStatusAchievement != null) {
        Uncomplete uncomplete = Uncomplete.uncompleteFromJson(jsonStatusAchievement);
        ref.read(statusAchievementNotifierProvider.notifier).setAchievement(uncomplete);
      } else {
        ref.read(statusAchievementNotifierProvider.notifier).setAchievement(Uncomplete(achievementRate: 0, uncompleteCount: 0));
      }

      // 'qna' 키가 null인 경우를 허용
      Map<String, dynamic>? jsonStatusQna = jsonLists['success']['qna'];
      if (jsonStatusQna != null) {
        Qna qna = Qna.fromJson(jsonStatusQna);
        ref.read(statusQnaNotifierProvider.notifier).setQna(qna);
      } else {
        ref.read(statusQnaNotifierProvider.notifier).setQna(Qna(question: "답변이 없습니다", answer: "답변이 없습니다"));
      }

      List<dynamic>? jsonTodaySchedule = jsonLists['success']['todaySchedule'];
      List<TodaySchedule> schedules = [];
      if (jsonTodaySchedule != null) {
        for (var jsonSchedule in jsonTodaySchedule) {
          schedules.add(TodaySchedule.fromJson(jsonSchedule));
        }
        try {
          ref.read(todayScheduleStateNotifierProvider.notifier).addSchedules(schedules);
          debugPrint('스케줄 $schedules');
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } else {
      debugPrint('Error: Missing success key in JSON response');
    }
  } else {
    debugPrint('Error: ${response.statusCode}');
  }
}
