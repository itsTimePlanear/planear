import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/avatar_item_state.dart';
import 'package:planear/theme/avatar_root.dart';

class AvatarWatching extends StateNotifier<AvatarItemState> {
  AvatarWatching() : super(nothing);
  void setFace(int index) {
    final String? face = ('${AvatarRoot.face_root}face$index.png' == state.face)
        ? null
        : '${AvatarRoot.face_root}face$index.png';

    AvatarItemState newState = AvatarItemState(
        lower_hair: state.lower_hair,
        upper_hair: state.upper_hair,
        face: face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setHair(int index) {
    String? lower_hair;
    String? upper_hair;
    if ('${AvatarRoot.lower_hair_root}lower_hair$index.png' !=
        state.lower_hair) {
      lower_hair = '${AvatarRoot.lower_hair_root}lower_hair$index.png';
      upper_hair = '${AvatarRoot.upper_hair_root}upper_hair$index.png';
    }

    AvatarItemState newState = AvatarItemState(
        lower_hair: lower_hair,
        upper_hair: upper_hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setTop(int index) {
    final String? top = ('${AvatarRoot.top_root}top$index.png' == state.top)
        ? null
        : '${AvatarRoot.top_root}top$index.png';

    AvatarItemState newState = AvatarItemState(
        lower_hair: state.lower_hair,
        upper_hair: state.upper_hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setPants(int index) {
    final String? pants =
        ('${AvatarRoot.pants_root}pants$index.png' == state.pants)
            ? null
            : '${AvatarRoot.pants_root}pants$index.png';

    AvatarItemState newState = AvatarItemState(
        lower_hair: state.lower_hair,
        upper_hair: state.upper_hair,
        face: state.face,
        pants: pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setShoes(int index) {
    final String? shoes =
        ('${AvatarRoot.shoes_root}shoes$index.png' == state.shoes)
            ? null
            : '${AvatarRoot.shoes_root}shoes$index.png';

    AvatarItemState newState = AvatarItemState(
        lower_hair: state.lower_hair,
        upper_hair: state.upper_hair,
        face: state.face,
        pants: state.pants,
        shoes: shoes,
        top: state.top,
        accessory: state.accessory,
        etc: state.etc);
    state = newState;
  }

  void setAcc(int index) {
    final String? accessory =
        ('${AvatarRoot.accessory_root}accessory$index.png' == state.accessory)
            ? null
            : '${AvatarRoot.accessory_root}accessory$index.png';
    AvatarItemState newState = AvatarItemState(
        lower_hair: state.lower_hair,
        upper_hair: state.upper_hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: accessory,
        etc: state.etc);
    state = newState;
  }

  void setEtc(int index) {
    final String? etc = ('${AvatarRoot.etc_root}etc$index.png' == state.etc)
        ? null
        : '${AvatarRoot.etc_root}etc$index.png';
    AvatarItemState newState = AvatarItemState(
        lower_hair: state.lower_hair,
        upper_hair: state.upper_hair,
        face: state.face,
        pants: state.pants,
        shoes: state.shoes,
        top: state.top,
        accessory: state.accessory,
        etc: etc);
    state = newState;
  }

  void copy(AvatarItemState value) {
    AvatarItemState newState = AvatarItemState(
      accessory: value.accessory,
      body: value.body,
      etc: value.etc,
      face: value.face,
      lower_hair: value.lower_hair,
      pants: value.pants,
      shoes: value.shoes,
      top: value.top,
      upper_hair: value.upper_hair,
    );
    state = newState;
  }
}

final avatarWatchingStateNotifierProvider =
    StateNotifierProvider<AvatarWatching, AvatarItemState>((ref) {
  return AvatarWatching();
});
