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
    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    if (jsonResponse['success'] != null) {
      final successData = jsonResponse['success'];

      if (successData != null) {
        List<ItemsAcievement> itemsMy = (successData['items'] as List<dynamic>)
            .map<ItemsAcievement>((item) => ItemsAcievement.fromJson([item]))
            .toList();

        Achievement achievementMy = Achievement(
            nickname: successData['nickname'],
            items: itemsMy,
            achievementRate: successData['achievementRate'],
            todayScheduleCount: successData['todayScheduleCount']);

        ref
            .read(achievementNotifierProvider.notifier)
            .addAchievement(achievementMy);

        debugPrint('내 달성률: ${achievementMy.toString()}');

        if (successData['friendInfos'] != null) {
          for (var friendJson in successData['friendInfos']) {
            List<ItemsAcievement> items = (friendJson['items'] as List<dynamic>)
                .map<ItemsAcievement>(
                    (item) => ItemsAcievement.fromJson([item]))
                .toList();

            Achievement achievement = Achievement(
                nickname: friendJson['nickname'],
                items: items,
                achievementRate: friendJson['achievementRate'],
                todayScheduleCount: friendJson['todayScheduleCount']);

            debugPrint('친구 달성률: ${achievement.toString()}');

            ref
                .read(achievementNotifierProvider.notifier)
                .addAchievement(achievement);
          }
        } else {
          debugPrint('친구 널일때');
        }
      } else {
        debugPrint('데이터 업슴');
      }
    } else {
      debugPrint('달성률 에러: success field is null');
    }
  } else {
    debugPrint('달성률 에러: ${response.statusCode.toString()}');
  }
}
