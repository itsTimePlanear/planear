import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_item_state_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_watching_riverpod.dart';

class AvatarMyItem extends ConsumerStatefulWidget {
  final int index;
  const AvatarMyItem(this.index, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarMyItemState();
}

class _AvatarMyItemState extends ConsumerState<AvatarMyItem> {
  @override
  Widget build(BuildContext context) {
    final int index = widget.index;
    final looking = ref.watch(lookingAvatarItemStateNotifierProvider);
    final watchingController =
        ref.read(avatarWatchingStateNotifierProvider.notifier);
    return GestureDetector(
      onTap: () {
        if (looking == LookingAvatarState.face) {
          watchingController.setFace(index);
        } else if (looking == LookingAvatarState.hair) {
          watchingController.setHair(index);
        } else if (looking == LookingAvatarState.top) {
          watchingController.setTop(index);
        } else if (looking == LookingAvatarState.pants) {
          watchingController.setPants(index);
        } else if (looking == LookingAvatarState.shoes) {
          watchingController.setShoes(index);
        }
        //  else if (looking == LookingAvatarState.accessory) {
        //   shoppingController.setAcc(index);
        // }
        else if (looking == LookingAvatarState.etc) {
          watchingController.setEtc(index);
        }
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: _items(looking, index),
      ),
    );
  }

  Widget _items(LookingAvatarState looking, int index) {
    return Container(
      width: 90,
      height: 75,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('${looking.root}${index}_view.png'),
              fit: BoxFit.fitWidth)),
    );
  }
}
