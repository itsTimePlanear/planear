import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/mainpage_rierpod.dart';

class MainAppBar extends ConsumerStatefulWidget {
  const MainAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final idxRead = ref.read(bottomChangeStateNotifierProvider.notifier);
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
                        image: DecorationImage(
                            image: AssetImage('assets/images/coin.png'))),
                  ),
                  const Gap(3),
                  const Text('num')
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                idxRead.setPage(0);
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/calendar_page.png'))),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
                onTap: () {
                  idxRead.setPage(1);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/my_page.png'))),
                ))
          ],
        ));
  }
}
