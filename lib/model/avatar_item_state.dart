enum AvatarItemState {
  lower_hair('헤어_아래',null),
  body('몸',null),
  face('얼굴', null),
  pants('하의', null),
  shoes('신발', null),
  top('상의', null),
  upper_hair('헤어', null),
  accessory('악세사리', null),
  etc('기타', null);

  final String name;
  final String? path;
  const AvatarItemState(this.name, this.path);
}
