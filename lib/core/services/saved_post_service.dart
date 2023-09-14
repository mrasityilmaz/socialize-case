import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class SavedPostService extends ChangeNotifier {
  factory SavedPostService() => instance;

  SavedPostService._internal();

  static final SavedPostService instance = SavedPostService._internal();

  List<String> _mySavedPostIds = List.empty(growable: true);

  List<String> get mySavedPosts => _mySavedPostIds.toSet().toList();

  void setMySavedPostIds(List<String> value) {
    _mySavedPostIds = List.from(value);
    notifyListeners();
  }

  void addsavedPostId(String postId) {
    _mySavedPostIds.add(postId);
    notifyListeners();
  }

  void removeSavedPostId(String postId) {
    _mySavedPostIds.remove(postId);
    notifyListeners();
  }

  bool isSaved(String postId) {
    return _mySavedPostIds.contains(postId);
  }
}
