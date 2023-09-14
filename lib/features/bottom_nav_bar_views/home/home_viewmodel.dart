import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class HomeViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  HomeViewModel();

  final ScrollController _scrollController = ScrollController();

  int _page = 0;
  final int _limit = 20;

  List<PostModel> _posts = List.empty(growable: true);

  List<PostModel> get posts => _posts;

  ScrollController get scrollController => _scrollController;

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
    final list = await locator<IPostRepository>().getPosts(page: _page, limit: _limit, lastPostModel: _posts.isNotEmpty ? _posts.last : null);
    final clearList = list.getOrElse(() => []);

    if (list.isRight()) {
      _posts = clearList;

      if (_posts.length % _limit == 0 && _posts.isNotEmpty) {
        _page++;
      }
    }
  }

  void addNewPost(PostModel postModel) {
    _posts.insert(0, postModel);
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }
}
