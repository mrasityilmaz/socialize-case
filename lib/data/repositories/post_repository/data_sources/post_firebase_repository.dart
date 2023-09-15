import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/constants/firebase_constants.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/services/like_service.dart';
import 'package:my_coding_setup/core/services/saved_post_service.dart';
import 'package:my_coding_setup/core/services/user_service.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/data_sources/iremote_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';
import 'package:uuid/uuid.dart';

@Environment('real')
@LazySingleton(as: IPostRemoteRepository)
class PostFirebaseRepository implements IPostRemoteRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<DataModel<PostModel>> createPost({required File image, required String caption}) async {
    try {
      final uuid = const Uuid().v4();
      final String imageUrl = await _firebaseStorage.ref('${FirebaseAuth.instance.currentUser?.uid}').child('post/$uuid').putFile(image).then((p0) async {
        final String downloadUrl = await p0.ref.getDownloadURL();
        debugPrint(downloadUrl);

        return downloadUrl;
      });

      final postModel = PostModel(
        description: caption,
        userName: locator<UserService>().userModel?.userDataModel.username ?? '',
        userImageUrl: locator<UserService>().userModel?.userDataModel.profileImageUrl ?? '',
        imageUrl: imageUrl,
        userId: FirebaseAuth.instance.currentUser!.uid,
        createdAt: DateTime.now().toUtc(),
        id: uuid,
      );

      await FirebaseConstants.instance.postCollection.doc(uuid).set(postModel.toJson(), SetOptions(merge: true));

      return Right(postModel);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<List<PostModel>>> getPosts({required int page, required int limit, PostModel? lastPostModel}) async {
    try {
      List<PostModel?> postList = List.empty(growable: true);

      if (lastPostModel != null) {
        final DocumentSnapshot last = await FirebaseConstants.instance.postCollection.doc(lastPostModel.id).get();
        postList = await FirebaseConstants.instance.postCollection.orderBy('createdAt', descending: true).startAfterDocument(last).limit(limit).get().then(
          (value) {
            return value.docs.map((e) {
              if (PostModel.isOkey(e.data())) {
                return PostModel.fromJson(e.data());
              } else {
                return null;
              }
            }).toList();
          },
        );
      } else {
        postList = await FirebaseConstants.instance.postCollection.orderBy('createdAt', descending: true).limit(limit).get().then(
          (value) {
            return value.docs.map((e) {
              if (PostModel.isOkey(e.data())) {
                return PostModel.fromJson(e.data());
              } else {
                return null;
              }
            }).toList();
          },
        );
      }

      return Right(postList.where((element) => element != null).cast<PostModel>().toList());
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<void>> likePost({required String postId}) async {
    try {
      await FirebaseConstants.instance.postCollection.doc(postId).update(
        {
          'likesCount': FieldValue.increment(1),
        },
      );
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        await FirebaseConstants.instance.userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'likedPosts': FieldValue.arrayUnion([postId]),
          },
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<void>> savePost({required String postId}) async {
    try {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        await FirebaseConstants.instance.userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'savedPosts': FieldValue.arrayUnion([postId]),
          },
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<void>> unlikePost({required String postId}) async {
    try {
      await FirebaseConstants.instance.postCollection.doc(postId).update(
        {
          'likesCount': FieldValue.increment(-1),
        },
      );
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        await FirebaseConstants.instance.userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'likedPosts': FieldValue.arrayRemove([postId]),
          },
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<void>> unsavePost({required String postId}) async {
    try {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        await FirebaseConstants.instance.userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'savedPosts': FieldValue.arrayRemove([postId]),
          },
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<List<PostModel>>> getLikedOrSavedPosts({required int limit, PostModel? lastPostModel}) async {
    try {
      final List<String> likedPosts = locator<LikeService>().myLikedPostIds;
      final List<String> savedPosts = locator<SavedPostService>().mySavedPosts;
      final List<String> likedOrSavedPosts = [...likedPosts, ...savedPosts];
      List<PostModel?> postList = List.empty(growable: true);

      if (lastPostModel != null) {
        final DocumentSnapshot last = await FirebaseConstants.instance.postCollection.doc(lastPostModel.id).get();
        postList = await FirebaseConstants.instance.postCollection.where(FieldPath.documentId, whereIn: likedOrSavedPosts).startAfterDocument(last).limit(limit).get().then(
          (value) {
            return value.docs.map((e) {
              if (PostModel.isOkey(e.data())) {
                return PostModel.fromJson(e.data());
              } else {
                return null;
              }
            }).toList();
          },
        );
      } else {
        postList = await FirebaseConstants.instance.postCollection.where(FieldPath.documentId, whereIn: likedOrSavedPosts).limit(limit).get().then(
          (value) {
            return value.docs.map((e) {
              if (PostModel.isOkey(e.data())) {
                return PostModel.fromJson(e.data());
              } else {
                return null;
              }
            }).toList();
          },
        );
      }

      return Right(postList.where((element) => element != null).cast<PostModel>().toList());
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<List<PostModel>>> getMyPosts({required int limit, PostModel? lastPostModel}) async {
    try {
      List<PostModel?> postList = List.empty(growable: true);
      final result = await FirebaseConstants.instance.postCollection.where('userId', isEqualTo: locator<UserService>().userModel?.userDataModel.userId).get();

      if (result.docs.isNotEmpty) {
        postList = result.docs.map((e) {
          if (PostModel.isOkey(e.data())) {
            return PostModel.fromJson(e.data());
          } else {
            return null;
          }
        }).toList();
      }

      return Right(postList.where((element) => element != null).cast<PostModel>().toList());
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
