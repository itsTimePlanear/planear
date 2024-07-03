import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:planear/model/schedule.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';

Future<bool> makeSchedule(WidgetRef ref) async {
  final url = Uri.parse('${UrlRoot.root}/schedule');
  final id = ref.watch(idChangeStateNotifierProvider);
  Schedule schedule = ref.watch(scheduleStateNotifierProvider);
  final response = await http.post(url,
      headers: {'user-no': id.toString(), 'Content-Type': 'application/json'},
      body: scheduleToJson(schedule));
  if (response.statusCode == 200) {
    return true;
  } else {
    debugPrint('스케줄 생성: ${response.statusCode.toString()}');
    return false;
  }
}
