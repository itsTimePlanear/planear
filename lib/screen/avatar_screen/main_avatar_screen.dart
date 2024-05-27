import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_item_state_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_shopping_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_watching_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/widgets/avatar_widget.dart';

class MainAvatarPage extends ConsumerStatefulWidget {
  const MainAvatarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainAvatarScreenState();
}

class _MainAvatarScreenState extends ConsumerState<MainAvatarPage> {
  @override
  Widget build(BuildContext context) {
    final avatarPageContorller =
        ref.read(avatarPageChangeStateNotifierProvider.notifier);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          const Gap(30),
          _infoBar(),
          const Gap(27),
          _character(),
          const Gap(50),
          _bottomNavBar(avatarPageContorller)
        ],
      ),
    );
  }

  _infoBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width - 50,
      height: 125,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 2,
            'planear님 현재 미완료된 일정이 \nn개 남아있어요.',
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          Gap(10),
          Row(
            children: [
              Text(
                '일정을 완료하고 코인을 획득하세요!',
                style: TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 13,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  print('이동하기');
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: Color(0xFF2F2E2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _character() {
    return const Column(
      children: [
        AvatarShower(200, 300),
        Gap(12),
        Text(
          'planear',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  _bottomNavBar(AvatarPageChange controller) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 60,
      child: Row(
        children: [
          const Spacer(),
          GestureDetector(
              onTap: () {
                ref
                    .read(lookingAvatarItemStateNotifierProvider.notifier)
                    .setState(LookingAvatarState.face);
                controller.setPage(AvatarPageState.myItem);
                final items = ref.watch(avatarWearingStateNotifierProvider);
                ref
                    .read(avatarWatchingStateNotifierProvider.notifier)
                    .copy(items);
              },
              child: const Column(
                children: [
                  Icon(Icons.person_add, size: 28),
                  Gap(3),
                  Text('내 아이템',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                      ))
                ],
              )),
          const Spacer(),
          GestureDetector(
              onTap: () {
                ref
                    .read(lookingAvatarItemStateNotifierProvider.notifier)
                    .setState(LookingAvatarState.face);
                controller.setPage(AvatarPageState.shop);
                final items = ref.watch(avatarWearingStateNotifierProvider);
                ref
                    .read(avatarShoppingStateNotifierProvider.notifier)
                    .copy(items);
              },
              child: const Column(
                children: [
                  Icon(Icons.shopping_basket, size: 28),
                  Gap(3),
                  Text('상점',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                      ))
                ],
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
