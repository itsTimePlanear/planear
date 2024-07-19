import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/acievement.dart';
import 'package:planear/riverpod/social_riverpod/achievement_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;


Future<void> achievementGet(WidgetRef ref) async {
  debugPrint('getAchievement');
  ref.read(achievementNotifierProvider.notifier).setListEmpty();

  final url = Uri.parse('${UrlRoot.root}/achievementRate');
  int id = ref.watch(idChangeStateNotifierProvider);
  final response = await http.get(url, headers: {'user-no': id.toString()});

  if (response.statusCode == 200) {
    debugPrint('getAchievement 호출 성공');
    final jsonLists = jsonDecode(response.body);

    if (jsonLists['success'] != null) {
      final achievements = jsonLists['success'];

      var myAchievementJson = achievements[0];
      List<ItemsAcievement> itemsMy = (myAchievementJson['items'] as List<dynamic>)
          .map<ItemsAcievement>((item) => ItemsAcievement.fromJson(item))
          .toList();

      Achievement achievementMy = Achievement(
          nickname: myAchievementJson['nickname'],
          items: itemsMy,
          achievementRate: myAchievementJson['achievementRate'],
          todayScheduleCount: myAchievementJson['todayScheduleCount']);
      ref.read(achievementNotifierProvider.notifier).addAchievement(achievementMy);

      for (var friendJson in achievements[0]['friendInfos']) {
        List<ItemsAcievement> items = (friendJson['items'] as List<dynamic>)
            .map<ItemsAcievement>((item) => ItemsAcievement.fromJson(item))
            .toList();

        Achievement achievement = Achievement(
            nickname: friendJson['nickname'],
            items: items,
            achievementRate: friendJson['achievementRate'],
            todayScheduleCount: friendJson['todayScheduleCount']);
        ref.read(achievementNotifierProvider.notifier).addAchievement(achievement);
      }
    } else {
      debugPrint('달성률 에러${response.statusCode.toString()}');
    }
  }
}