import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class LikeService extends ChangeNotifier {
  factory LikeService() => instance;

  LikeService._internal();

  static final LikeService instance = LikeService._internal();

  List<String> _myLikedPostIds = List.empty(growable: true);

  List<String> get myLikedPostIds => _myLikedPostIds.toSet().toList();

  void setMyLikedPostIds(List<String> value) {
    _myLikedPostIds = List.from(value);
    notifyListeners();
  }

  void addLikedPostId(String postId) {
    _myLikedPostIds.add(postId);
    notifyListeners();
  }

  void removeLikedPostId(String postId) {
    _myLikedPostIds.remove(postId);
    notifyListeners();
  }

  bool isLiked(String postId) {
    return _myLikedPostIds.contains(postId);
  }
}
