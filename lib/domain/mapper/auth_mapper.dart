import 'package:fanitek_test/data/model/auth_model/auth_model.dart';
import 'package:fanitek_test/domain/entity/auth/auth_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthMapper {
  AuthData mapModelToEntity(AuthModel model) {
    return AuthData(
      uid: model.uid ?? '',
      email: model.email ?? '',
      displayName: model.displayName ?? '',
      emailVerified: model.emailVerified ?? false,
      isAnonymous: model.isAnonymous ?? false,
      providerIds: model.providerIds != null
          ? model.providerIds!.map((id) => id).toList()
          : [],
      phoneNumber: model.phoneNumber ?? '',
      creationTime: model.creationTime?.toIso8601String() ?? '',
      lastSignInTime: model.lastSignInTime?.toIso8601String() ?? '',
    );
  }

  AuthModel mapEntityToModel(AuthData entity) {
    return AuthModel(
      uid: entity.uid,
      email: entity.email,
      displayName: entity.displayName,
      emailVerified: entity.emailVerified,
      isAnonymous: entity.isAnonymous,
      providerIds: entity.providerIds,
      phoneNumber: entity.phoneNumber,
      creationTime: DateTime.tryParse(entity.creationTime),
      lastSignInTime: DateTime.tryParse(entity.lastSignInTime),
    );
  }
}
