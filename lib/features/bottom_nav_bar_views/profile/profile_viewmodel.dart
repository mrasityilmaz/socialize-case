import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class ProfileViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  ProfileViewModel() {
    setInitialised(true);
  }

  List<PostModel> _posts = List.empty(growable: true);

  List<PostModel> get posts => _posts.toSet().toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  void setPostList(List<PostModel> value) {
    _posts = value;
    notifyListeners();
  }

  void addPostToList(PostModel post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  Future<void> getMyPosts() async {
    final list = await runBusyFuture(locator<IPostRepository>().getMyPosts(limit: 20, lastPostModel: _posts.isNotEmpty ? _posts.last : null));
    final clearList = list.getOrElse(() => []);
    if (list.isRight()) {
      _posts = clearList;
    }
  }
}
