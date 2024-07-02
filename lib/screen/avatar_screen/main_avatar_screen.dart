import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/dummydata/dummydata.dart';
import 'package:planear/model/item.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_item_state_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_shopping_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_wearing_riverpod.dart';
import 'package:planear/riverpod/user_riverpod.dart';
import 'package:planear/theme/url_root.dart';
import 'package:planear/widgets/avatar_widget.dart';
import 'package:http/http.dart' as http;

class MainAvatarPage extends ConsumerStatefulWidget {
  const MainAvatarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainAvatarScreenState();
}

class _MainAvatarScreenState extends ConsumerState<MainAvatarPage> {
  Future<void> getItems() async {
    debugPrint('statement');
    int category = 1;
    final url = Uri.parse('${UrlRoot.root}/avatar/store/$category');
    int id = ref.watch(idChangeStateNotifierProvider);
    final response = await http.get(url, headers: {'user-no': 16.toString()});

    if (response.statusCode == 200) {
      final jsonLists = jsonDecode(response.body);
      List<dynamic> jsonItems = jsonLists['success']['items'];
      // for (var element in jsonItems) {
      //   items.add(Item.fromJson(element));
      // }
      List<Item> items = [];
      items = dummyItems;
      debugPrint('store api 변경 후 연동 필요');
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

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
          _bottomNavBar(avatarPageContorller),
          GestureDetector(
            onTap: () async {
              getItems();
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.black,
            ),
          )
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
    final wearing = ref.watch(avatarWearingStateNotifierProvider);

    return Column(
      children: [
        AvatarShower(200, 300, wearing),
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
      child: GestureDetector(
          onTap: () {
            ref
                .read(lookingAvatarItemStateNotifierProvider.notifier)
                .setState(LookingAvatarState.face);
            controller.setPage(AvatarPageState.myItem);
            final items = ref.watch(avatarWearingStateNotifierProvider);
            ref.read(avatarShoppingStateNotifierProvider.notifier).copy(items);
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
    );
  }
}
