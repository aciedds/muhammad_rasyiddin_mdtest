import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/domain/repository/user_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateFirstNameLastNameUc {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  UpdateFirstNameLastNameUc(this._userRepository, this._authRepository);

  Future<DataState<bool>> call({
    required String firstName,
    required String lastName,
    required String id,
  }) async {
    final resultAuth = await _authRepository.updateDisplayName(
      displayName: "$firstName $lastName",
    );
    return resultAuth.when(
      success: (data) async => await _userRepository.updateFirstNameLastName(
        id: id,
        firstName: firstName,
        lastName: lastName,
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(message: message);
      },
    );
  }
}
