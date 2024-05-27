import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_my_item/avatar_my_item_page.dart';
import 'package:planear/screen/avatar_screen/avatar_shop/avatar_shop_item_container.dart';
import 'package:planear/screen/avatar_screen/avatar_shop/avatar_shop_screen.dart';
import 'package:planear/screen/avatar_screen/main_avatar_screen.dart';

class AvatarPage extends ConsumerStatefulWidget {
  const AvatarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarPageState();
}

class _AvatarPageState extends ConsumerState<AvatarPage> {
  @override
  Widget build(BuildContext context) {
    final idxState = ref.watch(avatarPageChangeStateNotifierProvider);
    final List<Widget> _widgetOptions = <Widget>[
      const AvatarPage(),
      const AvatarShopScreen(),
      const AvatarMyItemScreen()
    ];
    if (AvatarPageState.main == idxState) {
      return const MainAvatarPage();
    } else if (AvatarPageState.shop == idxState) {
      return const AvatarShopScreen();
    } else if (AvatarPageState.myItem == idxState) {
      return const AvatarMyItemScreen();
    }
    return Container();
  }
}
