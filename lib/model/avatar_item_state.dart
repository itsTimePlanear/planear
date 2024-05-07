import 'package:planear/theme/assets.dart';

enum AvatarItemState {
  lower_hair('헤어_아래', Assets.avatar_lower_hair_root),
  body('몸', Assets.avatar_body_root),
  face('얼굴', Assets.avatar_face_root),
  pants('하의', Assets.avatar_pants_root),
  shoes('신발', Assets.avatar_shoes_root),
  top('상의', Assets.avatar_top_root),
  upper_hair('헤어', Assets.avatar_upper_hair_root),
  accessory('악세사리', Assets.avatar_accessory),
  etc('기타', Assets.avatar_etc);

  final String name;
  final String? path;
  const AvatarItemState(this.name, this.path);
}
