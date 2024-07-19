import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;


Future<void> achievementGet(WidgetRef ref) async{
  debugPrint('getAchievement');

  final url = Uri.parse('${UrlRoot.root}/achievementRate');
    int id = ref.watch(idChangeStateNotifierProvider);
    final response = await http.get(url, headers: {'user-no': id.toString()});

    if(response.statusCode == 200){
      debugPrint('getAchievement호출 성공');
      final jsonLists = jsonDecode(response.body);

      
    }
}