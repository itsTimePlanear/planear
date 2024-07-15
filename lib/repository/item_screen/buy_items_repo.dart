import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';

Future<bool> buyItems(WidgetRef ref, List<Item> items) async {
  debugPrint('buy Items');
  final url = Uri.parse('${UrlRoot.root}/avatar/store/buy');
  int id = ref.watch(idChangeStateNotifierProvider);
  for (Item item in items) {
    final response = await http.post(url,
        headers: {'user-no': id.toString(), 'Content-Type': 'application/json'},
        body: jsonEncode({'itmeId': '${item.id}'}));
    if (response.statusCode == 200) {
      debugPrint('$id items 호출 성공');
    } else {
      return false;
    }
  }
  return true;
}
