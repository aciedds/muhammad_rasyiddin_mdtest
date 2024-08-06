import 'package:fanitek_test/data/model/auth_model/auth_model.dart';
import 'package:fanitek_test/data/source/auth_remote_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthRemote authRemote;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authRemote = AuthRemote(mockFirebaseAuth);
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
  });

  group('AuthRemote', () {
    test('loginWithAuthEmailPassword returns success DataState', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      )).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await authRemote.loginWithAuthEmailPassword(
        email: 'test@test.com',
        password: 'password',
      );
      result.when(
        success: (data) {
          expect(data, isA<AuthModel>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('registerWithAuthEmailPassword returns success DataState', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      )).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await authRemote.registerWithAuthEmailPassword(
        email: 'test@test.com',
        password: 'password',
      );

      result.when(
        success: (data) {
          expect(data, isA<AuthModel>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('logout returns success DataState', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      final result = await authRemote.logout();

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('sendPasswordResetEmail returns success DataState', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: 'test@test.com'))
          .thenAnswer((_) async {});

      final result =
          await authRemote.sendPasswordResetEmail(email: 'test@test.com');

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('sendEmailVerification returns success DataState', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.sendEmailVerification()).thenAnswer((_) async {});

      final result = await authRemote.sendEmailVerification();

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updateEmail returns success DataState', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.email).thenReturn('old@test.com');
      when(mockUser.reauthenticateWithCredential(any))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.verifyBeforeUpdateEmail(any)).thenAnswer((_) async {});

      final result = await authRemote.updateEmail(
        password: 'password',
        newEmail: 'new@test.com',
      );

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updatePassword returns success DataState', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.email).thenReturn('test@test.com');
      when(mockUser.reauthenticateWithCredential(any))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.updatePassword(any)).thenAnswer((_) async {});

      final result = await authRemote.updatePassword(
        currentPassword: 'currentPassword',
        newPassword: 'newPassword',
      );

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updateDisplayName returns success DataState', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.updateDisplayName(any)).thenAnswer((_) async {});

      final result =
          await authRemote.updateDisplayName(displayName: 'New Name');

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('updatePhotoURL returns success DataState', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.updatePhotoURL(any)).thenAnswer((_) async {});

      final result = await authRemote.updatePhotoURL(photoURL: 'new_photo_url');

      result.when(
        success: (data) {
          expect(data, isA<bool>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getCurrentUserData returns success DataState', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final result = await authRemote.getCurrentUserData();

      result.when(
        success: (data) {
          expect(data, isA<AuthModel>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });
  });
}
