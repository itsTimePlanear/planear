import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/repository/avatar_screen/avatar_wear_repo.dart';
import 'package:planear/repository/social_screen/achievement_repo.dart';
import 'package:planear/repository/social_screen/comment_question.dart';
import 'package:planear/repository/social_screen/feed_repo.dart';
import 'package:planear/riverpod/avatar_screen_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/calendar_page_riverpod/schedule_riverpod/schedule_modal_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/screen/item_screen/item_screen.dart';
import 'package:planear/screen/avatar_screen/main_avatar_screen.dart';
import 'package:planear/screen/calendar_screen/calendar_screen_modal_bottom_sheet.dart';
import 'package:planear/screen/calendar_screen/main_calendar_screen.dart';
import 'package:planear/screen/social_screen/custom_drawer.dart';
import 'package:planear/screen/social_screen/social_screen.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/theme/colors.dart';
import 'package:planear/repository/coin_repo.dart';
import 'package:planear/repository/schedule_repo.dart';
import 'package:planear/widgets/bottom_navigationbar.dart';
import 'package:planear/widgets/custom_main_appbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void didChangeDependencies() {
    ref
        .read(avatarWearingProvider.notifier)
        .setAvatarFromJson(ref.read(idChangeStateNotifierProvider));
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
    Future.microtask(() async {
      await achievementGet(ref);
      //await getStatus(ref);

      //await feedGet(ref);
    });
    final currentPage = ref.watch(bottomNavProvider);

    final defaultScreen = [
      const MainCalendarScreen(),
      const AvatarPage(),
      const ItemScreen(),
      const SocialScreen(),
    ];
    final scheduleState = ref.watch(scheduleModalNotifierProvider);
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFF4F4F4),
            endDrawer: CustomDrawer(),
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60), child: CustomMainAppbar()),
            body: SafeArea(child: defaultScreen.elementAt(currentPage)),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.grey200,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: AppColors.sub_black,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.navi_calendar,
                  ),
                  activeIcon:
                      SvgPicture.asset("assets/icons/bottom_calendar.svg"),
                  label: "일정",
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.navi_mypage),
                    activeIcon:
                        SvgPicture.asset("assets/icons/bottom_mypage.svg"),
                    label: "내 아바타"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.navi_closet),
                    activeIcon: SvgPicture.asset("assets/icons/bottom_box.svg"),
                    label: "아이템"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(Assets.navi_social),
                    activeIcon:
                        SvgPicture.asset("assets/icons/bottom_globar.svg"),
                    label: "소셜"),
              ],
              currentIndex: currentPage,
              onTap: (index) {
                ref.read(bottomNavProvider.notifier).state = index;
              },
            ),
          ),
          scheduleState ? const ScheduleModalBottomSheet() : Container()
        ],
      ),
    );
  }
}
