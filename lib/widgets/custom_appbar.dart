import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/mainpage_rierpod.dart';
import 'package:planear/theme/assets.dart';

class MainAppBar extends ConsumerStatefulWidget {
  const MainAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final mainPageController =
        ref.read(mainPageChangeStateNotifierProvider.notifier);
    final avatarPageController =
        ref.read(avatarPageChangeStateNotifierProvider.notifier);
    final pageState = ref.watch(mainPageChangeStateNotifierProvider);
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
                  const Text('num')
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                mainPageController.setPage(0);
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: pageState == 0
                            ? const AssetImage(Assets.calendar_select)
                            : const AssetImage(Assets.calendar))),
              ),
            ),
            const SizedBox(width: 16),
            _avatarPageButton(
                mainPageController, avatarPageController, pageState)
          ],
        ));
  }

  Widget _avatarPageButton(MainPageChange mainPagecontroller,
      AvatarPageChange avatarPageController, int pageState) {
    return GestureDetector(
        onTap: () {
          mainPagecontroller.setPage(1);
          avatarPageController.setPage(AvatarPageState.main);
        },
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: pageState == 1
                      ? const AssetImage(Assets.my_page_select)
                      : const AssetImage(Assets.my_page))),
        ));
  }
}
