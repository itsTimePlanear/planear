import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/a_rierpod.dart';
import 'package:planear/widgets/bottom.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idxState = ref.watch(bottomChangeStateNotifierProvider);
    final List<Widget> widgetOptions = <Widget>[
      Container(), //일정
      Container(), //내 아바타
    ];
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: widgetOptions.elementAt(idxState),
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
