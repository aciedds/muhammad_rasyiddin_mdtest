import 'package:fanitek_test/domain/entity/auth/auth_data.dart';
import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUc {
  final AuthRepository _authRepository;

  LoginUc(this._authRepository);

  Future<DataState<AuthData>> call({
    required String email,
    required String password,
  }) async =>
      await _authRepository.loginWithAuthEmailPassword(
        email: email,
        password: password,
      );
}
