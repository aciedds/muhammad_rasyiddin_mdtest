import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePasswordUc {
  final AuthRepository _authRepository;

  UpdatePasswordUc(this._authRepository);

  Future<DataState<bool>> call({
    required String currentPassword,
    required String newPassword,
  }) async =>
      await _authRepository.updatePassword(
        newPassword: newPassword,
        currentPassword: currentPassword,
      );
}
