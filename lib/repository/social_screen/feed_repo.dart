import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        String nickname = jsonLists['success']['response'];
        
       }
      
    }
}