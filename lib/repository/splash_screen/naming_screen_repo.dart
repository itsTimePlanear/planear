import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/main.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/local_db.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;

Future<bool> checkName(String name) async {
  final url = Uri.parse('${UrlRoot.root}/user/check');
  final response = await http.post(url,
      body: jsonEncode({'name': name}),
      headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    debugPrint('이름 확인 완');

    return true;
  } else if (response.statusCode == 400) {
    debugPrint('이름 겹침!');
    return false;
  }
  return false;
}

Future<bool> makeNewName(
    BuildContext context, String name, WidgetRef ref) async {
  final url = Uri.parse('${UrlRoot.root}/user');
  final response = await http.post(url,
      body: jsonEncode({'name': name}),
      headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    debugPrint('이름 생성 완');
    int uid = jsonDecode(response.body)['success']['id'];
    String code = jsonDecode(response.body)['success']['memberCode'];
    ref.read(nameChangeStateNotifierProvider.notifier).setName(name);
    ref.read(idChangeStateNotifierProvider.notifier).setId(uid);
    ref.read(codeChangeStateNotifierProvider.notifier).setCode(code);
    await storage.write(key: LocalDB.name, value: name);
    await storage.write(key: LocalDB.id, value: uid.toString());
    await storage.write(key: LocalDB.memberCode, value: code);
    debugPrint('이름 $name $uid');
    debugPrint('친구추가코드 $code');
    return true;
  } else {
    debugPrint('이름 생성 오류 - ${response.statusCode}');
    return false;
  }
}
