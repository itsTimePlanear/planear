import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_view_riverpod.dart';
import 'package:planear/riverpod/coin_riverpod.dart';
import 'package:planear/riverpod/mainpage_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_page.dart';
import 'package:planear/screen/calendar_screen/calendar_screen_modal_bottom_sheet.dart';
import 'package:planear/screen/calendar_screen/main_calendar_screen.dart';
import 'package:planear/theme/url_root.dart';
import 'package:planear/widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void didChangeDependencies() {
    getCoin();
    super.didChangeDependencies();
  }

  getCoin() async {
    final url = Uri.parse('${UrlRoot.root}/user/coin');
    String id = ref.watch(idChangeStateNotifierProvider).toString();
    debugPrint(id);
    final response = await http.get(url, headers: {'user-no': '10'});
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      final coin = await jsonDecode(response.body)['success']['amount'];
      debugPrint('코인 수:$coin');

      ref.read(coinChangeStateNotifierProvider.notifier).setCoin(coin);
    } else {
      debugPrint(response.body);
    }
  }

  getSchedule(start, end) async {
    final url = Uri.parse(
        '${UrlRoot.root}/schedule?startInclusive=$start&endInclusive=$end');
    String id = ref.watch(idChangeStateNotifierProvider).toString();
    debugPrint(id);
    final response = await http.get(url, headers: {'user-no': id});
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      List schedules = await jsonDecode(response.body)['success'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final idxState = ref.watch(mainPageChangeStateNotifierProvider);
    final scheduleState = ref.watch(scheduleWatchNotifierProvider);
    final List<Widget> widgetOptions = <Widget>[
      const MainCalendarScreen(), //일정
      const AvatarPage(), //내 아바타
    ];
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFF4F4F4),
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60), child: MainAppBar()),
            body: SafeArea(
              child: widgetOptions.elementAt(idxState),
            ),
          ),
          scheduleState ? const ScheduleModalBottomSheet() : Container()
        ],
      ),
    );
  }
}
