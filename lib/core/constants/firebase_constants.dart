import 'package:cloud_firestore/cloud_firestore.dart';

final class FirebaseConstants {
  factory FirebaseConstants() => instance;

  FirebaseConstants._internal();

  static final FirebaseConstants instance = FirebaseConstants._internal();

  static final CollectionReference<Map<String, dynamic>> _userCollection = FirebaseFirestore.instance.collection('users');

  CollectionReference<Map<String, dynamic>> get userCollection => _userCollection;
}
