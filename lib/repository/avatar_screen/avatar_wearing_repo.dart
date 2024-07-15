import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getWearingItems(int id) async {
  debugPrint('get wearing Items');
  final url = Uri.parse('${UrlRoot.root}/avatar/me');
  final response = await http.post(url, headers: {'user-no': id.toString()});
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    debugPrint('get wearing Itmes Failed :${response.statusCode}');
  }
  return null;
}
