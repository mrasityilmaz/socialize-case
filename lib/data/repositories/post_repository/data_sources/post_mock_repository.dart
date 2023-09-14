import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/data_sources/iremote_repository.dart';

@Environment('mock')
@LazySingleton(as: IPostRemoteRepository)
class PostMockRepository implements IPostRemoteRepository {
  @override
  Future<DataModel<PostModel>> createPost({required File image, required String caption}) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<DataModel<List<PostModel>>> getPosts({required int page, required int limit, PostModel? lastPostModel}) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<DataModel<void>> likePost({required String postId}) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<DataModel<void>> savePost({required String postId}) {
    // TODO: implement savePost
    throw UnimplementedError();
  }

  @override
  Future<DataModel<void>> unlikePost({required String postId}) {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }

  @override
  Future<DataModel<void>> unsavePost({required String postId}) {
    // TODO: implement unsavePost
    throw UnimplementedError();
  }

  @override
  Future<DataModel<List<PostModel>>> getLikedOrSavedPosts({required int limit, PostModel? lastPostModel}) {
    // TODO: implement getLikedOrSavedPosts
    throw UnimplementedError();
  }
}
