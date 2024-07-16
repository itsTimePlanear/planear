import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/questions.dart';
import 'package:planear/riverpod/social_riverpod/questions_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;


Future<void> getQuestion(WidgetRef ref) async{
  final url = Uri.parse('${UrlRoot.root}/questions');
  final response = await http.post(url,
  headers: {'Content-Type': 'application/json'});

  if (response.statusCode ==200){
    debugPrint('질문조회성공');
    final jsonLists = jsonDecode(response.body);
    List<dynamic> jsonQuestions = jsonLists['success']['questions'];
    List<Questions> questions = [];
    for(var jsonQuestion in jsonQuestions){
      questions.add(Questions.questionFromJson(jsonQuestion));
    }
    try {
        ref.read(questionNotifierProvider.notifier)
        .addFriendInfos(questions);
        debugPrint(questions.toString());
      } catch(e){
        debugPrint(e.toString());
      }
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
