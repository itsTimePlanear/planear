import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/model/item.dart';
import 'package:planear/repository/avatar_screen/avatar_wear_repo.dart';
import 'package:planear/repository/item_screen/buy_items_repo.dart';
import 'package:planear/riverpod/coin_riverpod.dart';
import 'package:planear/riverpod/item_screen_riverpod/item_view_state_riverpod.dart';
import 'package:planear/riverpod/item_screen_riverpod/avatar_items_riverpod.dart';
import 'package:planear/riverpod/item_screen_riverpod/shopping_riverpod.dart';
import 'package:planear/riverpod/avatar_screen_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/screen/item_screen/item_container.dart';
import 'package:planear/repository/item_screen/get_items_repo.dart';
import 'package:planear/utils/item_utils.dart';
import 'package:planear/widgets/avatar_widget.dart';
import 'package:planear/widgets/bottom_navigationbar.dart';
import 'package:planear/widgets/custom_dialog.dart';

class ItemScreen extends ConsumerStatefulWidget {
  const ItemScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemScreenState();
}

class _ItemScreenState extends ConsumerState<ItemScreen> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(avatarShoppingStateNotifierProvider.notifier)
          .setAvatar(ref.read(avatarWearingProvider));
      ref
          .read(lookingAvatarItemStateNotifierProvider.notifier)
          .setState(LookingAvatarState.hair);

      await getItems(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogContorller =
        ref.read(lookingAvatarItemStateNotifierProvider.notifier);
    final avatarPageState = ref.watch(lookingAvatarItemStateNotifierProvider);
    final items = ref.watch(itemsStateNotifierProvider);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          _character(),
          const Spacer(),
          _bottom(catalogContorller, avatarPageState, items),
        ],
      ),
    );
  }

  Widget _character() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: AvatarShower(null, MediaQuery.sizeOf(context).height * 0.3,
          ref.watch(avatarShoppingStateNotifierProvider)),
    );
  }

  Widget _bottom(LookingAvatarItem catalogContorller,
      LookingAvatarState avatarPageState, List<Item> items) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.6 - 80,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: Column(
        children: [
          const Gap(24),
          _controlBar(catalogContorller, avatarPageState),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.3),
              itemCount: items
                  .where((test) => test.category == avatarPageState.num)
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return ItemContainer(items
                    .where((test) => test.category == avatarPageState.num)
                    .toList()[index]);
              },
            ),
          ),
          const Spacer(),
          _twoButton(),
          const Gap(15)
        ],
      ),
    );
  }

  Widget _controlBar(
      LookingAvatarItem catalogContorller, LookingAvatarState avatarPageState) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 48,
      child: CarouselSlider.builder(
        carouselController: _controller,
        itemCount: LookingAvatarState.values.length,
        options: CarouselOptions(
          viewportFraction: 0.16,
          enableInfiniteScroll: false,
          autoPlay: false,
          onPageChanged: (index, reason) {
            catalogContorller.setState(LookingAvatarState.values[index]);
          },
        ),
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () {
              if (mounted) {
                _controller.animateToPage(realIndex);
              }
            },
            child: Container(
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    LookingAvatarState.values[index].name,
                    style: LookingAvatarState.values[index] == avatarPageState
                        ? const TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1)
                        : const TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0.9,
                          ),
                  ),
                  const Gap(5),
                  LookingAvatarState.values[index] == avatarPageState
                      ? Container(
                          width: 28,
                          height: 2,
                          color: Colors.black,
                        )
                      : Container()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _twoButton() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Spacer(),
          GestureDetector(
            onTap: () {
              ref
                  .read(avatarShoppingStateNotifierProvider.notifier)
                  .setAvatar(ref.read(avatarWearingProvider));
            },
            child: Container(
              width: 159,
              height: 48,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFF4F4F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '취소',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFDC0000),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              int coin = ref.read(coinChangeStateNotifierProvider);
              AvatarItemState shoppingItemState =
                  ref.watch(avatarShoppingStateNotifierProvider);
              int userId = ref.read(idChangeStateNotifierProvider);
              List<Item> noneItemList = noneItems(shoppingItemState);
              int cost = noneItemList.length * 3;
              if (cost > 0) {
                if (await showCustomDialog(
                    context,
                    '구매하지 않은 아이템이 포함되어 있습니다.\n코인 $cost개를 사용하여 아이템을 구매할까요?',
                    '취소',
                    '구매하기')) {
                  if (cost <= coin) {
                    if (await buyItems(userId, noneItemList)) {
                      AvatarItemState items =
                          ref.read(avatarShoppingStateNotifierProvider);
                      ref.read(avatarWearingProvider.notifier).setAvatar(items);
                      ref
                          .read(coinChangeStateNotifierProvider.notifier)
                          .minusCoin(cost);
                      wearItems(ref, shoppingItemState, userId);

                      ref.read(bottomNavProvider.notifier).state = 1;
                    }
                  }
                }
              } else if (cost == 0) {
                AvatarItemState items =
                    ref.read(avatarShoppingStateNotifierProvider);
                ref.read(avatarWearingProvider.notifier).setAvatar(items);
                wearItems(ref, shoppingItemState, userId);
                if (ref.read(coinChangeStateNotifierProvider) > cost) {
                  ref.read(bottomNavProvider.notifier).state = 1;
                }
              }
            },
            child: Container(
              width: 163,
              height: 48,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFF2F2E2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '코디 적용하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
