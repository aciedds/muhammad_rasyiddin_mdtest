import 'package:fanitek_test/domain/entity/auth/auth_data.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';

abstract class AuthRepository {
  Future<DataState<AuthData>> loginWithAuthEmailPassword({
    required String email,
    required String password,
  });

  Future<DataState<AuthData>> registerWithAuthEmailPassword({
    required String email,
    required String password,
  });

  Future<DataState<bool>> logout();

  Future<DataState<bool>> sendPasswordResetEmail({required String email});

  Future<DataState<bool>> sendEmailVerification();

  Future<DataState<bool>> deleteUser();

  Future<DataState<bool>> updateEmail({
    required String newEmail,
    required String password,
  });

  Future<DataState<bool>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<DataState<bool>> updateDisplayName({required String displayName});

  Future<DataState<bool>> updatePhotoURL({required String photoURL});

  Future<DataState<AuthData>> getCurrentUserData();
}
