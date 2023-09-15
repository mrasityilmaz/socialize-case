import 'dart:io';

import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';

abstract class IPostRepository {
  Future<DataModel<PostModel>> createPost({required File image, required String caption});
  Future<DataModel<List<PostModel>>> getMyPosts({required int limit, PostModel? lastPostModel});
  Future<DataModel<List<PostModel>>> getPosts({required int page, required int limit, PostModel? lastPostModel});
  Future<DataModel<List<PostModel>>> getLikedOrSavedPosts({required int limit, PostModel? lastPostModel});

  Future<DataModel<void>> likePost({required String postId});
  Future<DataModel<void>> unlikePost({required String postId});
  Future<DataModel<void>> savePost({required String postId});
  Future<DataModel<void>> unsavePost({required String postId});
}
