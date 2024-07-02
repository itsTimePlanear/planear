// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:planear/model/item.dart';
// import 'package:planear/riverpod/avatar_page_riverpod/avatar_item_state_riverpod.dart';
// import 'package:planear/riverpod/avatar_page_riverpod/avatar_shopping_riverpod.dart';
// import 'package:planear/theme/assets.dart';

// class AvatarShopItem extends ConsumerStatefulWidget {
//   final Item item;
//   const AvatarShopItem(this.item, {super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AvatarShopItemState();
// }

// class _AvatarShopItemState extends ConsumerState<AvatarShopItem> {
//   @override
//   Widget build(BuildContext context) {
//     final Item item = widget.item;
//     final looking = ref.watch(lookingAvatarItemStateNotifierProvider);
//     final shoppingController =
//         ref.read(avatarShoppingStateNotifierProvider.notifier);
//     return GestureDetector(
//       onTap: () {
//         if (looking == LookingAvatarState.face) {
//           shoppingController.setFace(item);
//         } else if (looking == LookingAvatarState.hair) {
//           shoppingController.setHair(item);
//         } else if (looking == LookingAvatarState.top) {
//           shoppingController.setTop(item);
//         } else if (looking == LookingAvatarState.pants) {
//           shoppingController.setPants(item);
//         } else if (looking == LookingAvatarState.shoes) {
//           shoppingController.setShoes(item);
//         }
//         //  else if (looking == LookingAvatarState.accessory) {
//         //   shoppingController.setAcc(items.url2);
//         // }
//         else if (looking == LookingAvatarState.etc) {
//           shoppingController.setEtc(item);
//         }
//       },
//       child: SizedBox(
//         width: MediaQuery.sizeOf(context).width,
//         child: _items(),
//       ),
//     );
//   }

//   Widget _items() {
//     return Container(
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       child: Column(
//         children: [_upper(), _lower()],
//       ),
//     );
//   }

//   Widget _upper() {
//     return Container(
//       width: 90,
//       height: 75,
//       alignment: Alignment.center,
//       margin: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//           image: DecorationImage(
//               image: NetworkImage(widget.item.url), fit: BoxFit.fitWidth)),
//     );
//   }

//   Widget _lower() {
//     return Container(
//       width: 90,
//       height: 25,
//       alignment: Alignment.center,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 16,
//             height: 16,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(image: ExactAssetImage(Assets.coin))),
//           ),
//           const Gap(7),
//           const Text(
//             '3',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Color(0xFF111111),
//               fontSize: 14,
//               fontFamily: 'Pretendard',
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
