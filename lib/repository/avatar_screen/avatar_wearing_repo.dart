import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>?> getWearingItems(int id) async {
  debugPrint('get wearing Items');
  final url = Uri.parse('${UrlRoot.root}/avatar/me');
  final response = await http.get(url, headers: {'user-no': id.toString()});
  if (response.statusCode == 200) {
    List value = (jsonDecode(response.body)["success"]["items"]);
    if (value.isEmpty) {
      return null;
    }
    return value.map((json) => json as Map<String, dynamic>).toList();
  } else {
    debugPrint('get wearing Itmes Failed :${response.statusCode}');
  }
  return null;
}
