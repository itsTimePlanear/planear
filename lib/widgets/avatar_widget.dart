import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_shopping_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_watching_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_wearing_riverpod.dart';

class AvatarShower extends ConsumerStatefulWidget {
  final double? width;
  final double? height;
  const AvatarShower(this.width, this.height, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarShowerState();
}

class _AvatarShowerState extends ConsumerState<AvatarShower> {
  @override
  Widget build(BuildContext context) {
    final wearing = ref.watch(avatarWearingStateNotifierProvider);
    final watching = ref.watch(avatarWatchingStateNotifierProvider);
    final shopping = ref.watch(avatarShoppingStateNotifierProvider);
    final avatarPageState = ref.watch(avatarPageChangeStateNotifierProvider);
    final value = (avatarPageState == AvatarPageState.main)
        ? wearing
        : (avatarPageState == AvatarPageState.myItem)
            ? watching
            : (avatarPageState == AvatarPageState.shop)
                ? shopping
                : wearing;
    final double? width = widget.width;
    final double? height = widget.height;
    return Stack(
      children: [
        _item(width, height, value.lower_hair), //헤어아래
        _item(width, height, value.body ?? defaultAvatar.body), //아바타 몸
        _item(width, height, value.face ?? defaultAvatar.face), //얼굴
        _item(width, height, value.pants), //하의
        _item(width, height, value.shoes), //신발
        _item(width, height, value.top), //상의
        _item(width, height, value.upper_hair), //헤어위
        // _item(width, height,watching.accessory?? shopping.accessory), //악세
        _item(width, height, value.etc), //기타
      ],
    );
  }

  Widget _item(double? width, double? height, String? asset) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: asset == null
          ? null
          : BoxDecoration(
              image: DecorationImage(image: AssetImage(asset), scale: 0.1)),
    );
  }
}
