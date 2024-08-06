import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/domain/repository/user_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateEmailUc {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  UpdateEmailUc(this._authRepository, this._userRepository);

  Future<DataState<bool>> call({
    required String id,
    required String newEmail,
    required String password,
  }) async {
    final result = await _authRepository.updateEmail(
      newEmail: newEmail,
      password: password,
    );

    return result.when(
      success: (data) async => await _userRepository.updateEmail(
        id: id,
        email: newEmail,
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(message: message);
      },
    );
  }
}
