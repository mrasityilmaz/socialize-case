import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class LikesAndSavesViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  LikesAndSavesViewModel();

  final int _limit = 2;
  int _page = 0;
  final UniqueKey _refreshIndicatorKey = UniqueKey();

  UniqueKey get refreshIndicatorKey => _refreshIndicatorKey;

  List<PostModel> _posts = List.empty(growable: true);

  List<PostModel> get posts => _posts.toSet().toList();

  void setPostList(List<PostModel> value) {
    _posts = value;
    notifyListeners();
  }

  Future<void> loadMore() async {
    await runBusyFuture(
      _getPosts(),
      busyObject: _refreshIndicatorKey,
    );
    notifyListeners();
  }

  Future<void> refresh() async {
    _page = 0;
    _posts.clear();

    await _getPosts(clear: true);
    notifyListeners();
  }

  Future<void> init() async {
    await runBusyFuture(
      _getPosts(),
    );

    setInitialised(true);
    notifyListeners();
  }

  Future<void> _getPosts({bool clear = false}) async {
    if (_page > (_posts.length ~/ _limit) && clear == false) {
      return;
    }
    final list = await locator<IPostRepository>().getLikedOrSavedPosts(limit: _limit, lastPostModel: _posts.isNotEmpty ? _posts.last : null);
    final clearList = list.getOrElse(() => []);

    if (list.isRight()) {
      if (clear) {
        _posts = clearList;
      } else {
        _posts.addAll(clearList);
      }

      if (_posts.length % _limit == 0 && _posts.isNotEmpty) {
        _page++;
      }
    }
  }

  void removePostFromList(String postId) {
    _posts.removeWhere((element) => element.id == postId);
    notifyListeners();
  }

  void addPostToList(PostModel post) {
    _posts.insert(0, post);
    notifyListeners();
  }
}
