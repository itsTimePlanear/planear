import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/mainpage_rierpod.dart';
import 'package:planear/widgets/custom_appbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final idxState = ref.watch(bottomChangeStateNotifierProvider);
    final List<Widget> widgetOptions = <Widget>[
      Container(), //일정
      Container(), //내 아바타
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: MainAppBar()),
      body: SafeArea(
        child: widgetOptions.elementAt(idxState),
      ),
    );
  }
}
