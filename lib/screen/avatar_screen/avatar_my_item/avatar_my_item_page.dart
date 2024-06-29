import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_item_state_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_watching_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_my_item/avatar_my_item_container.dart';
import 'package:planear/widgets/avatar_widget.dart';

class AvatarMyItemScreen extends ConsumerStatefulWidget {
  const AvatarMyItemScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarMyItemState();
}

class _AvatarMyItemState extends ConsumerState<AvatarMyItemScreen> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final catalogContorller =
        ref.read(lookingAvatarItemStateNotifierProvider.notifier);
    final avatarPageState = ref.watch(lookingAvatarItemStateNotifierProvider);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          _character(),
          const Spacer(),
          _bottom(catalogContorller, avatarPageState),
        ],
      ),
    );
  }

  Widget _character() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: AvatarShower(null, MediaQuery.sizeOf(context).height * 0.3),
    );
  }

  Widget _bottom(
      LookingAvatarItem catalogContorller, LookingAvatarState avatarPageState) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.57,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: Column(
        children: [
          const Gap(24),
          _controlBar(catalogContorller, avatarPageState),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.32,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.3),
              itemCount: avatarPageState.num,
              itemBuilder: (BuildContext context, int index) {
                return AvatarMyItem(index + 1);
              },
            ),
          ),
          const Gap(12),
          _twoButton(),
          const Gap(12)
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
                            height: 0.9)
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
    final pageContorller =
        ref.read(avatarPageChangeStateNotifierProvider.notifier);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Spacer(),
          GestureDetector(
            onTap: () {
              pageContorller.setPage(AvatarPageState.main);
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
            onTap: () {
              pageContorller.setPage(AvatarPageState.main);
              final items = ref.read(avatarWatchingStateNotifierProvider);
              ref
                  .read(avatarWearingStateNotifierProvider.notifier)
                  .setAvatar(items);
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
