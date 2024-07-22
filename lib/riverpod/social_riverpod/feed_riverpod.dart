import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:planear/model/social_model/feed.dart';

class FeedState extends StateNotifier<List<Feed>> {
  FeedState() : super([]);

  void setFeeds(List<Feed> feeds) {
    state = feeds;
  }

  void setListEmpty() {
    state = [];
  }

  void addFeed(Feed feed) {
    state = [...state, feed];
  }
}

final feedNotifierProvider = StateNotifierProvider<FeedState, List<Feed>>((ref) {
  return FeedState();
});