import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/a_rierpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BState();
}

class _BState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final idxRead = ref.read(bottomChangeStateNotifierProvider.notifier);
    final idxState = ref.watch(bottomChangeStateNotifierProvider);
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        enableFeedback: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined), label: '일정'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 아바타')
        ],
        currentIndex: idxState,
        iconSize: 24,
        onTap: (value) {
          idxRead.setValue(value);
        },
      ),
    );
  }
}
