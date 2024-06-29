import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_my_item/avatar_my_item_page.dart';
import 'package:planear/screen/avatar_screen/avatar_page.dart';
import 'package:planear/screen/calendar_screen/main_calendar_screen.dart';
import 'package:planear/theme/assets.dart';

class BottomNavState extends StateNotifier<int> {
  BottomNavState() : super(0);

  @override
  set state(int value) {
    super.state = value;
  }
}
final bottomNavProvider =
    StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());

class BottomNavigationbar extends ConsumerStatefulWidget{
  const BottomNavigationbar({Key? key}) : super(key: key);

  @override
  BottomNavigationbarState createState() => BottomNavigationbarState();
  
}

class BottomNavigationbarState extends ConsumerState<BottomNavigationbar>{
  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(bottomNavProvider);

    final defaultScreen = [
      const MainCalendarScreen(),
      const AvatarPage(),
      Container(child: Text("아이템화면"),),
      Container(child: Text("소셜화면"),),
    ];

    return Scaffold(
      body: SafeArea(child: defaultScreen.elementAt(currentPage)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.navi_calendar), label: "일정"),
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.navi_mypage), label: "내 아바타"),
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.navi_closet), label: "아이템"),
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.navi_social), label: "소셜"),

      ],
      currentIndex: currentPage,
      onTap: (index){
        ref.read(bottomNavProvider.notifier).state = index;
          
      },),
    );

  }
}