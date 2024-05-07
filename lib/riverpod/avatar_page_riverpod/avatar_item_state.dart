enum LookingAvatarState {
  body('몸'),
  face('얼굴'),
  lower_hair('헤어_아래'),
  pants('하의'),
  shoes('신발'),
  top('상의'),
  upper_hair('헤어_위');

  const LookingAvatarState(this.name);
  final String name;
}
