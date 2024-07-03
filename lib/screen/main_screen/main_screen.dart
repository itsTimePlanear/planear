import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/make_schedule_riverpod/make_schedule_watch_riverpod.dart';
import 'package:planear/riverpod/mainpage_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_page.dart';
import 'package:planear/screen/calendar_screen/calendar_screen_modal_bottom_sheet.dart';
import 'package:planear/screen/calendar_screen/main_calendar_screen.dart';
import 'package:planear/screen/social/custom_drawer.dart';
import 'package:planear/widgets/custom_appbar.dart';
import 'package:planear/widgets/custom_main_appbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final idxState = ref.watch(mainPageChangeStateNotifierProvider);
    final scheduleState = ref.watch(makeScheduleWatchNotifierProvider);
    final List<Widget> widgetOptions = <Widget>[
      const MainCalendarScreen(), //일정
      const AvatarPage(), //내 아바타
    ];
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            endDrawer: CustomDrawer(),
            backgroundColor: const Color(0xFFF4F4F4),
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60), child: CustomMainAppbar()),
            body: SafeArea(
              child: widgetOptions.elementAt(idxState),
            ),
          ),
          scheduleState ? ScheduleModalBottomSheet() : Container()
        ],
      ),
    );
  }
}
