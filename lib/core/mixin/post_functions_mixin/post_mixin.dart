import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/services/like_service.dart';
import 'package:my_coding_setup/core/services/saved_post_service.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

mixin PostMixin {
  Future<void> likeOrDislikeFunction({required bool isLiked, required String postId}) async {
    final LikeService likeService = locator<LikeService>();

    debugPrint('Like button pressed');

    if (!isLiked) {
      likeService.addLikedPostId(postId);

      await locator<IPostRepository>().likePost(postId: postId).then((value) {
        if (value.isLeft()) {
          likeService.removeLikedPostId(postId);
        }
      });
    } else {
      likeService.removeLikedPostId(postId);
      await locator<IPostRepository>().unlikePost(postId: postId).then((value) {
        if (value.isLeft()) {
          likeService.addLikedPostId(postId);
        }
      });
    }
  }

  Future<void> saveOrUnSaveFunction({required bool isSaved, required String postId}) async {
    final SavedPostService savedPostService = locator<SavedPostService>();

    debugPrint('Saved button pressed');

    if (!isSaved) {
      savedPostService.addsavedPostId(postId);
      await locator<IPostRepository>().savePost(postId: postId).then((value) {
        if (value.isLeft()) {
          savedPostService.removeSavedPostId(postId);
        }
      });
    } else {
      savedPostService.removeSavedPostId(postId);
      await locator<IPostRepository>().unsavePost(postId: postId).then((value) {
        if (value.isLeft()) {
          savedPostService.addsavedPostId(postId);
        }
      });
    }
  }
}
