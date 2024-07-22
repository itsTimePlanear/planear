import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planear/model/item.dart';
import 'package:planear/theme/url_root.dart';

Future<bool> buyItems(int id, List<Item> items) async {
  debugPrint('buy Items');
  final url = Uri.parse('${UrlRoot.root}/avatar/store/buy');
  for (Item item in items) {
    final response = await http.post(url,
        headers: {'user-no': id.toString(), 'Content-Type': 'application/json'},
        body: jsonEncode({'itemId': '${item.id}'}));
    if (response.statusCode == 200) {
      debugPrint('$id item${item.id} 구매 성공');
    } else {
      debugPrint('${response.statusCode}');
      debugPrint('${item.id} 구매 실패');
      return false;
    }
  }
  return true;
}
