import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUc {
  final AuthRepository _authRepository;

  ForgotPasswordUc(this._authRepository);

  Future<DataState<bool>> call({required String email}) async {
    return await _authRepository.sendPasswordResetEmail(email: email);
  }
}
