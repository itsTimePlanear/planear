import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/screen/avatar_screen/avatar_shop/avatar_shop_item_container.dart';

class AvatarShopScreen extends ConsumerStatefulWidget {
  const AvatarShopScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AvatarShopScreenState();
}

class _AvatarShopScreenState extends ConsumerState<AvatarShopScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: _header()),
      body: _body(),
    );
  }

  Widget _header() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 30),
      width: MediaQuery.sizeOf(context).width - 30,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 63,
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE6E6E6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined, size: 28),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          _character(),
          const Spacer(),
          _items(),
        ],
      ),
    );
  }

  Widget _character() {
    return Container(
      height: 250,
      child: Stack(
        //다른 위젯(캐릭터 장신구)들 쌓기
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 200,
              alignment: Alignment.center,
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  print('object');
                },
                child: Text('캐릭터'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _items() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          if (index % 3 == 0) {
            return const Row(children: [
              AvatarShopItem(),
              AvatarShopItem(),
              AvatarShopItem()
            ]);
          }
          return Container();
        },
      ),
    );
  }
}
