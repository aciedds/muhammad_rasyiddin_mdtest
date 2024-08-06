import 'package:fanitek_test/data/source/auth_remote_source.dart';
import 'package:fanitek_test/domain/entity/auth/auth_data.dart';
import 'package:fanitek_test/domain/mapper/auth_mapper.dart';
import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemote _remote;
  final AuthMapper _mapper;

  AuthRepositoryImpl(this._remote, this._mapper);

  @override
  Future<DataState<bool>> deleteUser() async => await _remote.deleteUser();

  @override
  Future<DataState<AuthData>> getCurrentUserData() async {
    final result = await _remote.getCurrentUserData();
    return result.when(
      success: (data) => DataState.success(
        data: _mapper.mapModelToEntity(data),
      ),
      error: (message, code, statusCode, exception, stackTrace) {
        return DataState.error(message: message);
      },
    );
  }

  @override
  Future<DataState<AuthData>> loginWithAuthEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = await _remote.loginWithAuthEmailPassword(
      email: email,
      password: password,
    );
    return result.when(
      success: (data) => DataState.success(
        data: _mapper.mapModelToEntity(data),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(message: message);
      },
    );
  }

  @override
  Future<DataState<bool>> logout() async => await _remote.logout();

  @override
  Future<DataState<AuthData>> registerWithAuthEmailPassword({
    required String email,
    required String password,
  }) async {
    final result = await _remote.registerWithAuthEmailPassword(
      email: email,
      password: password,
    );
    return result.when(
      success: (data) => DataState.success(
        data: _mapper.mapModelToEntity(data),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(message: message);
      },
    );
  }

  @override
  Future<DataState<bool>> sendEmailVerification() async {
    return await _remote.sendEmailVerification();
  }

  @override
  Future<DataState<bool>> sendPasswordResetEmail({
    required String email,
  }) async {
    return await _remote.sendPasswordResetEmail(email: email);
  }

  @override
  Future<DataState<bool>> updateDisplayName(
      {required String displayName}) async {
    return await _remote.updateDisplayName(displayName: displayName);
  }

  @override
  Future<DataState<bool>> updateEmail({
    required String newEmail,
    required String password,
  }) {
    return _remote.updateEmail(newEmail: newEmail, password: password);
  }

  @override
  Future<DataState<bool>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _remote.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<DataState<bool>> updatePhotoURL({required String photoURL}) {
    return _remote.updatePhotoURL(photoURL: photoURL);
  }
}
