import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_buy_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_page_riverpod.dart';
import 'package:planear/riverpod/avatar_page_riverpod/avatar_shopping_riverpod.dart';
import 'package:planear/riverpod/coin_riverpod.dart';

class AvatarItemBuyDialog extends ConsumerStatefulWidget {
  final int value;
  const AvatarItemBuyDialog(this.value, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AvatarItemBuyDialogState();
}

class _AvatarItemBuyDialogState extends ConsumerState<AvatarItemBuyDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 311,
        height: 164,
        child: Column(
          children: [
            Container(
              width: 311,
              height: 116,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '코인 ${widget.value}개가 차감됩니다.\n구매할까요?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
                width: 311,
                height: 48,
                child: Row(
                  children: [_leftButton(), _rightButton()],
                ))
          ],
        ),
      ),
    );
  }

  Widget _leftButton() {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const ShapeDecoration(
          color: Color(0xFFF1F1F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
          ),
        ),
        child: const Text(
          '취소',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }

  Widget _rightButton() {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        ref
            .read(coinChangeStateNotifierProvider.notifier)
            .minusCoin(widget.value);
        Navigator.pop(context);
        ref.read(itemBuyStateNotifierProvider.notifier).setTrue();
        ref
            .read(avatarPageChangeStateNotifierProvider.notifier)
            .setPage(AvatarPageState.main);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const ShapeDecoration(
          color: Color(0xFF2F2E2C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
          ),
        ),
        child: const Text(
          '구매하기',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }
}
