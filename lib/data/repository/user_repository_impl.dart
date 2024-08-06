import 'package:fanitek_test/data/source/user_remote_source.dart';
import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/domain/mapper/user_mapper.dart';
import 'package:fanitek_test/domain/repository/user_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UsersRemote _remote;
  final UserMapper _mapper;

  UserRepositoryImpl(this._remote, this._mapper);

  @override
  Future<DataState<UserData>> getUserData(String uid) async {
    final result = await _remote.getUserData(uid);
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
  Future<DataState<UserData>> addUserData(UserData usersEntity) async {
    final result = await _remote.addUserData(
      model: _mapper.mapEntityToModel(usersEntity),
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
  Future<DataState<List<UserData>>> getListUserData({
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
  }) async {
    final result = await _remote.getFilteredUsers(
      firstName: firstName,
      lastName: lastName,
      email: email,
      isEmailVerified: isEmailVerified,
    );
    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _mapper.mapModelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(message: message);
      },
    );
  }

  @override
  Future<DataState<bool>> updateFirstNameLastName({
    required String id,
    required String firstName,
    required String lastName,
  }) async =>
      await _remote.updateFirstNameLastName(
        id: id,
        firstName: firstName,
        lastName: lastName,
      );

  @override
  Future<DataState<bool>> updateVerifyEmail({
    required String id,
    required bool isEmailVerified,
  }) async =>
      await _remote.updateVerifyEmail(
        id: id,
        isEmailVerified: isEmailVerified,
      );

  @override
  Future<DataState<bool>> updateEmail({
    required id,
    required String email,
  }) async =>
      await _remote.updateEmail(
        id: id,
        email: email,
      );
}
