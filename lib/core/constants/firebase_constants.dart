import 'package:cloud_firestore/cloud_firestore.dart';

final class FirebaseConstants {
  factory FirebaseConstants() => instance;

  FirebaseConstants._internal();

  static final FirebaseConstants instance = FirebaseConstants._internal();

  static final CollectionReference<Map<String, dynamic>> _userCollection = FirebaseFirestore.instance.collection('users');
  static final CollectionReference<Map<String, dynamic>> _postCollection = FirebaseFirestore.instance.collection('posts');
  void stop() {
    FirebaseFirestore.instance.settings = FirebaseFirestore.instance.settings.copyWith(persistenceEnabled: false);
    FirebaseFirestore.instance.clearPersistence();
    FirebaseFirestore.instance.terminate();
  }

  CollectionReference<Map<String, dynamic>> get userCollection => _userCollection;
  CollectionReference<Map<String, dynamic>> get postCollection => _postCollection;
}
