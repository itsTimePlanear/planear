import 'package:planear/theme/avatar_root.dart';

class AvatarItemState {
  String? lower_hair;
  String? body;
  String? face;
  String? pants;
  String? shoes;
  String? top;
  String? upper_hair;
  String? accessory;
  String? etc;
  AvatarItemState(
      {lower_hair, body, face, pants, shoes, top, upper_hair, accessory, etc}) {
    this.lower_hair = lower_hair;
    this.body = body;
    this.face = face;
    this.pants = pants;
    this.shoes = shoes;
    this.top = top;
    this.upper_hair = upper_hair;
    this.accessory = accessory;
    this.etc = etc;
  }
}

AvatarItemState defaultAvatar = AvatarItemState(
    body: '${AvatarRoot.body_root}default.png',
    face: '${AvatarRoot.face_root}default.png');

AvatarItemState nothing = AvatarItemState();
