import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/feed.dart';
import 'package:planear/riverpod/social_riverpod/feed_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;


Future<void> feedGet(WidgetRef ref) async{
  debugPrint('getFeed');
  ref.read(feedNotifierProvider.notifier).setListEmpty();

    final url = Uri.parse('${UrlRoot.root}/feed');
    int id = ref.watch(idChangeStateNotifierProvider);
    final response = await http.get(url, headers: {'user-no': id.toString()});

    if(response.statusCode == 200){
      debugPrint('피드 조회 성공');
      final jsonLists = jsonDecode(utf8.decode(response.bodyBytes));

       if (jsonLists['success'] != null) {
        final feeds = jsonLists['success']['response'] as List<dynamic>;

        for(var feedJson in feeds){
          List<Items> items = (feedJson['items'] as List<dynamic>).map<Items>((item){
            return Items.fromJson(item);
          }).toList();

          List<TodaySchedule> schedules = (feedJson['statusMessage']['todaySchedule'] as List<dynamic>).map<TodaySchedule>((item){
            return TodaySchedule.fromJson(item);
          }).toList();

           Map<String, dynamic>? jsonStatusAchievement = feedJson['statusMessage']['uncomplete'];
          Uncomplete uncomplete = jsonStatusAchievement != null
            ? Uncomplete.uncompleteFromJson(jsonStatusAchievement)
            : Uncomplete(uncompleteCount: 0, achievementRate: 0);

          Map<String, dynamic>? jsonStatusQna = feedJson['statusMessage']['qna'];
          Qna qna = jsonStatusQna != null
            ? Qna.fromJson(jsonStatusQna)
            : Qna(question: "", answer: "");

          Feed feed = Feed(
            nickname: feedJson['nickname'],
            type: feedJson['statusMessage']['type'],
            items: items,
            uncomplete: uncomplete,
            todaySchedule: schedules,
            qna: qna
            );
            ref.read(feedNotifierProvider.notifier).addFeed(feed);
        }
       }else {
      debugPrint('피드 에러${response.statusCode.toString()}');
    }
      
    }
}