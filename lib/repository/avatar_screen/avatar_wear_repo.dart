import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:planear/utils/item_utils.dart';

Future<bool> wearItems(WidgetRef ref, AvatarItemState shopping) async {
  debugPrint('wear Items');
  final url = Uri.parse('${UrlRoot.root}/avatar/me/wear');
  int id = ref.watch(idChangeStateNotifierProvider);
  List<Item> items = shoppingToList(shopping);
  for (Item item in items) {
    final response = await http.post(url,
        headers: {'user-no': id.toString(), 'Content-Type': 'application/json'},
        body: jsonEncode({'itemId': '${item.id}'}));
    if (response.statusCode == 200) {
      debugPrint('${item.id} items 호출 성공');
    } else {
      return false;
    }
  }
  return true;
}
