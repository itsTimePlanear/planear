import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/theme/assets.dart';

class AvatarShower extends ConsumerStatefulWidget {
  final double? width;
  final double? height;
  final AvatarItemState wearing;
  const AvatarShower(this.width, this.height, this.wearing, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarShowerState();
}

class _AvatarShowerState extends ConsumerState<AvatarShower> {
  @override
  Widget build(BuildContext context) {
    final wearing = widget.wearing;

    final double? width = widget.width;
    final double? height = widget.height;
    return Stack(
      children: [
        _item(width, height, wearing.hair?.urlAvatar1), //헤어아래
        _bodyContainer(width, height),
        _item(width, height, wearing.face?.urlAvatar1), //얼굴
        _item(width, height, wearing.pants?.urlAvatar1), //하의
        _item(width, height, wearing.shoes?.urlAvatar1), //신발
        _item(width, height, wearing.top?.urlAvatar1), //상의
        _item(width, height, wearing.hair?.urlAvatar2), //헤어위
        _item(width, height, wearing.accessory?.urlAvatar1), //악세
        _item(width, height, wearing.etc?.urlAvatar1), //기타
      ],
    );
  }

  Widget _item(double? width, double? height, String? asset) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: (asset == null || asset == '')
          ? null
          : BoxDecoration(
              image: DecorationImage(image: NetworkImage(asset), scale: 0.1)),
    );
  }

  Widget _bodyContainer(double? width, double? height) {
    return SvgPicture.asset(Assets.body, width: width, height: height);
  }
}
