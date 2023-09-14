import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class LikesAndSavesViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  LikesAndSavesViewModel();

  final int _limit = 20;

  List<PostModel> _posts = List.empty(growable: true);

  List<PostModel> get posts => _posts.toSet().toList();

  void setPostList(List<PostModel> value) {
    _posts = value;
    notifyListeners();
  }

  Future<void> init() async {
    await runBusyFuture(
      _getPosts(),
    );

    setInitialised(true);
    notifyListeners();
  }

  Future<void> _getPosts() async {
    final list = await locator<IPostRepository>().getLikedOrSavedPosts(limit: _limit, lastPostModel: _posts.isNotEmpty ? _posts.last : null);
    final clearList = list.getOrElse(() => []);

    if (list.isRight()) {
      _posts = clearList;

      if (_posts.length % _limit == 0 && _posts.isNotEmpty) {}
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
