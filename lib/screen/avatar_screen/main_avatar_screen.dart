import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainAvatarScreen extends ConsumerStatefulWidget {
  const MainAvatarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainAvatarScreenState();
}

class _MainAvatarScreenState extends ConsumerState<MainAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 200,
        color: Colors.grey,
      ),
    );
  }
}
