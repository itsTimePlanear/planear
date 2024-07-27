import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/item.dart';

class AvatarItems extends StateNotifier<List<Item>> {
  AvatarItems() : super([]);

  void setEmpty() {
    state = [];
  }

  void addItems(List<Item> items) {
    for (var item in items) {
      state.add(item);
    }
  }
}

final itemsStateNotifierProvider =
    StateNotifierProvider<AvatarItems, List<Item>>((ref) {
  return AvatarItems();
});
