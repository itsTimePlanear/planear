import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_modal_riverpod.dart';
import 'package:planear/riverpod/mainpage_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_page.dart';
import 'package:planear/screen/calendar_screen/calendar_screen_modal_bottom_sheet.dart';
import 'package:planear/screen/calendar_screen/main_calendar_screen.dart';
import 'package:planear/viewmodel/coin_view_model.dart';
import 'package:planear/viewmodel/schedule_view_model.dart';
import 'package:planear/widgets/custom_appbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void didChangeDependencies() {
    getCoin(ref);
    getSchedule(
        DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
        DateTime.now().add(const Duration(days: 30)),
        ref);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final idxState = ref.watch(mainPageChangeStateNotifierProvider);
    final scheduleState = ref.watch(scheduleModalNotifierProvider);
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
