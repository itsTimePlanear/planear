import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/coin_riverpod.dart';
//import 'package:planear/riverpod/mainpage_riverpod.dart';
import 'package:planear/screen/social_screen/custom_drawer.dart';
import 'package:planear/theme/assets.dart';

class CustomMainAppbar extends ConsumerStatefulWidget {
  const CustomMainAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomMainAppBarState();
}

class _CustomMainAppBarState extends ConsumerState<CustomMainAppbar> {
  @override
  Widget build(BuildContext context) {
    final coin = ref.watch(coinChangeStateNotifierProvider);
    //final isDrawerOpen = ref.read(drawerStateProvider.notifier);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
        height: 30,
        margin: const EdgeInsets.only(left: 12, right: 12, top: 30),
        child: Row(
          children: [
            SizedBox(
              width: 63,
              child: Row(
                children: [
                  Container(
                    width: 21,
                    height: 30,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Assets.coin))),
                  ),
                  const Gap(8),
                  Text(
                    '$coin',
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Svg(Assets.appbar_bell))),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
        onTap: () {
          print("누름");
          Scaffold.of(context).openEndDrawer();

        },
        
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Svg(Assets.appbar_hambur))),
        ))
          ],
        ));
  }
}
