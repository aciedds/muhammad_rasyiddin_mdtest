import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/domain/repository/user_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendEmailVerificationUc {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SendEmailVerificationUc(this._authRepository, this._userRepository);

  Future<DataState<bool>> call(String id) async {
    final authResult = await _authRepository.sendEmailVerification();
    return authResult.when(
      success: (data) async {
        final result = await _userRepository.updateVerifyEmail(
          id: id,
          isEmailVerified: true,
        );
        return result.when(
          success: (data) => const DataState.success(data: true),
          error: (message, data, exception, stackTrace, statusCode) =>
              DataState.error(message: message),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) =>
          DataState.error(message: message),
    );
  }
}
