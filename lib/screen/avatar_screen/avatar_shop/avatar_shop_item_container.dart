import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/assets.dart';
import 'package:planear/widgets/avatar_widget.dart';

class AvatarShopItem extends ConsumerStatefulWidget {
  const AvatarShopItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarShopItemState();
}

class _AvatarShopItemState extends ConsumerState<AvatarShopItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [_avatar(), const Spacer(), _items()],
      ),
    );
  }

  Widget _avatar() {
    return AvatarShower(null, MediaQuery.sizeOf(context).height * 0.3);
  }

  Widget _items() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      width: MediaQuery.sizeOf(context).width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Gap(24),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container();
            },
          ),
          const Gap(24),
          SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.9),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    print('item $index');
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 75,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        color: Colors.amber,
                        alignment: Alignment.center,
                      ),
                      Container(
                        width: 90,
                        height: 25,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/icons/coin.png'))),
                            ),
                            const Gap(7),
                            const Text(
                              '3',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
