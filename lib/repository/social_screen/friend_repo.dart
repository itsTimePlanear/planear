import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/friend.dart';
import 'package:planear/riverpod/social_riverpod/friend_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;


Future<bool> friendAdd(String code) async {
  final url = Uri.parse('${UrlRoot.root}/friends/add');
  final response = await http.post(url,
  body: jsonEncode({'memberCode' : code}),
  headers: {'Content-Type': 'application/json'});

  if(response.statusCode == 200){
    debugPrint('친구 추가 완료');

    return true;
  } else if(response.statusCode == 400){
    debugPrint('친구 정보가 존재하지 않습니다');
    return false;
  } else{
    debugPrint('친구 추가 api 에러');
    return false;
  }
}

Future<void> getFriendInfo(WidgetRef ref, String memberCode) async {
  debugPrint('getFriendInfo');
  ref.read(friendStateNotifierProvider.notifier).setEmpty();

  
    final url = Uri.parse('${UrlRoot.root}/member-info?memberCode=$memberCode');
    int id = ref.watch(idChangeStateNotifierProvider);
    final response = await http.get(url, headers: {'user-no': id.toString()});

    if(response.statusCode == 200){
      debugPrint('$id 친구 정보 조회 성공');
      final jsonLists = jsonDecode(response.body);
      String nickname = jsonLists['success']['nickname'];
      List<dynamic> jsonItems = jsonLists['success']['wearingLists'];
      List<Friend> friends = [];
      for(var jsonItem in jsonItems){
        friends.add(Friend.wearingFromJson(jsonItem));

      }
      try {
        ref.read(friendStateNotifierProvider.notifier)
        .addFriendInfos(friends);
      } catch(e){
        debugPrint(e.toString());
      }
    } else {
      debugPrint(response.statusCode.toString());
    }
}

  


