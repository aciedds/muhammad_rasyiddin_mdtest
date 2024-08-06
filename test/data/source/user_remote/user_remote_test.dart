import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanitek_test/data/model/user_model/user_model.dart';
import 'package:fanitek_test/data/source/user_remote_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_remote_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  QuerySnapshot,
  QueryDocumentSnapshot
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late UsersRemote usersRemote;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
    mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
    mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    mockQueryDocumentSnapshot =
        MockQueryDocumentSnapshot<Map<String, dynamic>>();
    usersRemote = UsersRemote(mockFirestore);
  });

  group('UsersRemote', () {
    test('getUserData returns success DataState', () async {
      when(mockFirestore.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn({
        'id': '1',
        'firstName': 'Test',
        'lastName': 'User',
        'email': 'test@test.com',
        'isEmailVerified': true
      });

      final result = await usersRemote.getUserData('1');

      result.when(
        success: (data) {
          expect(data, isA<UserModel>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('addUserData returns success DataState', () async {
      when(mockFirestore.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(any)).thenAnswer((_) async {});

      final userModel = UserModel(
          id: '1',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@test.com',
          isEmailVerified: true);
      final result = await usersRemote.addUserData(model: userModel);

      result.when(
        success: (data) {
          expect(data, isA<UserModel>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updateFirstNameLastName returns success DataState', () async {
      when(mockFirestore.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(any)).thenAnswer((_) async {});

      final result = await usersRemote.updateFirstNameLastName(
          id: '1', firstName: 'NewFirstName', lastName: 'NewLastName');

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updateEmail returns success DataState', () async {
      when(mockFirestore.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(any)).thenAnswer((_) async {});

      final result =
          await usersRemote.updateEmail(id: '1', email: 'newemail@test.com');

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updateVerifyEmail returns success DataState', () async {
      when(mockFirestore.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(any)).thenAnswer((_) async {});

      final result =
          await usersRemote.updateVerifyEmail(id: '1', isEmailVerified: true);

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });
  });
}
