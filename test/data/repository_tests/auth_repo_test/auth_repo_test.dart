import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final MockFirebaseAuth mockFirebaseAuth;
  late final FakeFirebaseFirestore mockFirebaseFirestore;

  late final String email;
  late final String password;
  late final String userId;

  setUpAll(() async {
    mockFirebaseAuth = MockFirebaseAuth(signedIn: true);
    mockFirebaseFirestore = FakeFirebaseFirestore();

    email = 'test@gmail.com';
    password = '123456';
  });

  group('Firebase Register and Check Test', () {
    test('Firebase Register', () async {
      final result = await mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (result.user != null && result.user?.uid != null) {
        userId = result.user!.uid;
        await mockFirebaseFirestore.collection('users').doc(result.user!.uid).set({
          'userData': {
            'userId': result.user!.uid,
            'email': result.user?.email ?? email,
          },
          'createdAt': DateTime.now().toUtc(),
        });
      }

      expect(
        result,
        isA<UserCredential>(),
      );
      expect(result.user, isNotNull);
      expect(result.user?.uid, isNotNull);
    });

    test('Check Firestore has a UserDoc', () async {
      final docResult = await mockFirebaseFirestore.collection('users').doc(userId).get();

      expect(docResult, isA<DocumentSnapshot>());
      expect(docResult.data()!['userData']['userId'].toString(), userId);
    });

    tearDown(() => mockFirebaseAuth.signOut());

    test('Firebase Login', () async {
      final result = await mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      expect(result, isA<UserCredential>());
      expect(result.user, isNotNull);
    });

    test('Firebase Sign Out', () async {
      await mockFirebaseAuth.signOut();

      expect(mockFirebaseAuth.currentUser, isNull);
    });

    test('Delete User From FireStore', () async {
      await mockFirebaseFirestore.collection('users').doc(userId).delete();

      final docDeletedResult = await mockFirebaseFirestore.collection('users').doc(userId).get();

      expect(docDeletedResult.data(), isNull);
    });
  });
}
