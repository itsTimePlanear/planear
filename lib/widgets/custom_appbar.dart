import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return SizedBox(
      height: 60,
      child: Container(
          height: 30,
          margin: const EdgeInsets.only(left: 12, right: 12, top: 30),
          child: Row(
            children: [
              Container(
                  width: 63,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE6E6E6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print('가방 button');
                  idxRead.setPage(0);
                },
                child: const Icon(Icons.work_outline_outlined, size: 28),
              ),
              const SizedBox(width: 19),
              GestureDetector(
                onTap: () {
                  print('사람 button');
                  idxRead.setPage(1);
                },
                child: const Icon(Icons.person_outline, size: 28),
              )
            ],
          )),
    );
  }
}
