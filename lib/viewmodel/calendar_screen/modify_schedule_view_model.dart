import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:planear/model/schedule.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';

Future<bool> modifySchedule(WidgetRef ref) async {
  Schedule schedule = ref.watch(scheduleStateNotifierProvider);
  final url = Uri.parse('${UrlRoot.root}/schedule/${schedule.id}');
  final id = ref.watch(idChangeStateNotifierProvider);
  final response = await http.put(url,
      headers: {'user-no': id.toString(), 'Content-Type': 'application/json'},
      body: jsonEncode(scheduleToJson(schedule)));
  if (response.statusCode == 200) {
    return true;
  } else {
    debugPrint('스케줄 변경: ${response.statusCode.toString()}');
    return false;
  }
}
