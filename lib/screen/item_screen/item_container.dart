import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/item_screen_riverpod/item_view_state_riverpod.dart';
import 'package:planear/riverpod/item_screen_riverpod/shopping_riverpod.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/utils/item_utils.dart';

class ItemContainer extends ConsumerStatefulWidget {
  final Item item;
  const ItemContainer(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemContainerState();
}

class _ItemContainerState extends ConsumerState<ItemContainer> {
  @override
  Widget build(BuildContext context) {
    final Item item = widget.item;
    final looking = ref.watch(lookingAvatarItemStateNotifierProvider);
    final shoppingController =
        ref.read(avatarShoppingStateNotifierProvider.notifier);
    final shoppingState = ref.watch(avatarShoppingStateNotifierProvider);
    return GestureDetector(
      onTap: () {
        if (looking == LookingAvatarState.face) {
          shoppingController.setFace(item);
        } else if (looking == LookingAvatarState.hair) {
          shoppingController.setHair(item);
        } else if (looking == LookingAvatarState.top) {
          shoppingController.setTop(item);
        } else if (looking == LookingAvatarState.pants) {
          shoppingController.setPants(item);
        } else if (looking == LookingAvatarState.shoes) {
          shoppingController.setShoes(item);
        } else if (looking == LookingAvatarState.accessory) {
          shoppingController.setAcc(item);
        } else if (looking == LookingAvatarState.etc) {
          shoppingController.setEtc(item);
        }
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: _items(looking, item, shoppingState),
      ),
    );
  }

  Widget _items(
      LookingAvatarState looking, Item item, AvatarItemState shoppingState) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            item == checkLooking(looking, shoppingState)
                ? SvgPicture.asset(Assets.selected_item_container)
                : Container(),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                children: [_upper(looking, item), _lower(item)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _upper(LookingAvatarState looking, Item item) {
    return Container(
      width: 89,
      height: 75,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(item.url), fit: BoxFit.fitWidth)),
    );
  }

  Widget _lower(Item item) {
    return Container(
      width: 90,
      height: 26,
      alignment: Alignment.center,
      child: item.has
          ? const Text('보유중')
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.coin))),
                ),
                const Gap(7),
                Text(item.price.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400)),
              ],
            ),
    );
  }
}
