import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/item_screen_riverpod/avatar_items_riverpod.dart';
import 'package:planear/riverpod/item_screen_riverpod/item_view_state_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;

Future<void> getItems(WidgetRef ref) async {
  debugPrint('getItems');
  ref.read(itemsStateNotifierProvider.notifier).setEmpty();

  for (int category = 1; category < 8; category++) {
    final url = Uri.parse('${UrlRoot.root}/avatar/store/$category');
    int id = ref.watch(idChangeStateNotifierProvider);
    final response = await http.get(url, headers: {'user-no': id.toString()});

    if (response.statusCode == 200) {
      debugPrint('$id items 호출 성공');
      final jsonLists = jsonDecode(response.body);
      List<dynamic> jsonItems = jsonLists['success']['items'];
      List<Item> items = [];
      for (var jsonItem in jsonItems) {
        items.add(Item.fromJsonWithCategory(jsonItem, category));
      }
      try {
        ref.read(itemsStateNotifierProvider.notifier).addItems(items);
      } catch (e) {
        break;
      }
      if (category == 1) {
        ref
            .read(lookingAvatarItemStateNotifierProvider.notifier)
            .setState(LookingAvatarState.face);
      }
    } else {
      debugPrint(response.statusCode.toString());
      break;
    }
  }
}
