import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/dummydata/item_dummy.dart';
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;

Future<void> getItems(WidgetRef ref) async {
  debugPrint('getItems');
  int category = 1;
  final url = Uri.parse('${UrlRoot.root}/avatar/store/$category');
  int id = ref.watch(idChangeStateNotifierProvider);
  final response = await http.get(url, headers: {'user-no': 16.toString()});

  if (response.statusCode == 200) {
    final jsonLists = jsonDecode(response.body);
    List<dynamic> jsonItems = jsonLists['success']['items'];
    // for (var element in jsonItems) {
    //   items.add(Item.fromJson(element));
    // }
    List<Item> items = [];
    items = dummyItems;
    debugPrint('store api 변경 후 연동 필요');
  } else {
    debugPrint(response.statusCode.toString());
  }
}
