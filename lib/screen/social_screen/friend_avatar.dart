import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/model/social_model/acievement.dart';
import 'package:planear/theme/assets.dart';

class AvatarShowerFriend extends ConsumerStatefulWidget {
  final double? width;
  final double? height;
  final List<ItemsAcievement> wearing;
  const AvatarShowerFriend(this.width, this.height, this.wearing, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarShowerFriendState();
}

class _AvatarShowerFriendState extends ConsumerState<AvatarShowerFriend> {
  @override
  Widget build(BuildContext context) {
    final wearing = widget.wearing;

    final double? width = widget.width;
    final double? height = widget.height;
    return Stack(
       children: [
        _bodyContainer(width, height), 
        _item(width, height, 'https://planear.s3.amazonaws.com/DEFAULT/default_body.png'), 
        _item(width, height, wearing.isNotEmpty && wearing.first.face?.urlAvatar1 != null
            ? wearing.first.face?.urlAvatar1
            : 'https://planear.s3.amazonaws.com/DEFAULT/default_eyes2.png'), 
        for (var wearingItem in wearing) ...[
          _item(width, height, wearingItem.hair?.urlAvatar1), // 헤어아래
          _item(width, height, wearingItem.pants?.urlAvatar1), // 하의
          _item(width, height, wearingItem.shoes?.urlAvatar1), // 신발
          _item(width, height, wearingItem.top?.urlAvatar1), // 상의
          _item(width, height, wearingItem.hair?.urlAvatar2), // 헤어위
          _item(width, height, wearingItem.accessory?.urlAvatar1), // 악세
          _item(width, height, wearingItem.etc?.urlAvatar1), // 기타
        ],
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
