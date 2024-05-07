import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/theme/assets.dart';

class AvatarShower extends ConsumerStatefulWidget {
  final double? width;
  final double? height;
  const AvatarShower(this.width, this.height, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarShowerState();
}

class _AvatarShowerState extends ConsumerState<AvatarShower> {
  @override
  Widget build(BuildContext context) {
    final double? width = widget.width;
    final double? height = widget.height;
    return Stack(
      children: [
        _item(width, height,
            '${Assets.avatar_lower_hair_root}lower_hair1.png'), //헤어아래
        _item(width, height, '${Assets.avatar_body_root}default.png'), //아바타 몸
        _item(width, height, '${Assets.avatar_face_root}default.png'), //얼굴
        _item(width, height, '${Assets.avatar_pants_root}pants1.png'), //하의
        _item(width, height, '${Assets.avatar_shoes_root}shoes1.png'), //신발
        _item(width, height, '${Assets.avatar_top_root}top1.png'), //상의
        _item(width, height,
            '${Assets.avatar_upper_hair_root}upper_hair1.png'), //헤어위
        // _item(width, height, '${Assets.avatar_accessory}default.png'), //악세
        // _item(width, height, '${Assets.avatar_guitar}default.png'), //기타
      ],
    );
  }

  Widget _item(double? width, double? height, String asset) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(asset), scale: 0.1)),
    );
  }
}
