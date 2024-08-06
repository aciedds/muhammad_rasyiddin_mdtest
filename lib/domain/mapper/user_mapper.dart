import 'package:fanitek_test/data/model/user_model/user_model.dart';
import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserMapper {
  UserData mapModelToEntity(UserModel data) {
    return UserData(
      firstName: data.firstName ?? '',
      lastName: data.lastName ?? '',
      id: data.id ?? '',
      isEmailVerified: data.isEmailVerified ?? false,
      email: data.email ?? '',
    );
  }

  UserModel mapEntityToModel(UserData data) {
    return UserModel(
      firstName: data.firstName,
      lastName: data.lastName,
      id: data.id,
      email: data.email,
      isEmailVerified: data.isEmailVerified,
    );
  }
}
