import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';

abstract class UserRepository {
  Future<DataState<UserData>> getUserData(String uid);

  Future<DataState<UserData>> addUserData(UserData usersEntity);

  Future<DataState<bool>> updateFirstNameLastName({
    required String id,
    required String firstName,
    required String lastName,
  });

  Future<DataState<bool>> updateVerifyEmail({
    required String id,
    required bool isEmailVerified,
  });

  Future<DataState<bool>> updateEmail({
    required String id,
    required String email,
  });

  Future<DataState<List<UserData>>> getListUserData({
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
  });
}
