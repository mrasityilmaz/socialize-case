import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/platform/network_info.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/data_sources/ilocal_repository.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/data_sources/iremote_repository.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';

@LazySingleton(as: IPostRepository)
class PostRepository implements IPostRepository {
  const PostRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final IPostRemoteRepository remoteDataSource;
  final IPostLocalRepository localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<DataModel<PostModel>> createPost({required File image, required String caption}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.createPost(caption: caption, image: image);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<List<PostModel>>> getPosts({required int page, required int limit, PostModel? lastPostModel}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getPosts(page: page, limit: limit, lastPostModel: lastPostModel);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<void>> likePost({required String postId}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.likePost(postId: postId);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<void>> savePost({required String postId}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.savePost(postId: postId);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<void>> unlikePost({required String postId}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.unlikePost(postId: postId);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<void>> unsavePost({required String postId}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.unsavePost(postId: postId);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<List<PostModel>>> getLikedOrSavedPosts({required int limit, PostModel? lastPostModel}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getLikedOrSavedPosts(limit: limit, lastPostModel: lastPostModel);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<List<PostModel>>> getMyPosts({required int limit, PostModel? lastPostModel}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getMyPosts(limit: limit, lastPostModel: lastPostModel);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }
}
