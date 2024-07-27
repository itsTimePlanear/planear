import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/coin_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:http/http.dart' as http;

getCoin(WidgetRef ref) async {
  final url = Uri.parse('${UrlRoot.root}/user/coin');
  String id = ref.watch(idChangeStateNotifierProvider).toString();
  debugPrint(id);
  final response = await http.get(url, headers: {'user-no': id});
  if (response.statusCode == 200) {
    final coin = await jsonDecode(response.body)['success']['amount'];
    debugPrint('코인 수:$coin');

    ref.read(coinChangeStateNotifierProvider.notifier).setCoin(coin);
  } else {
    debugPrint(response.body);
  }
}
