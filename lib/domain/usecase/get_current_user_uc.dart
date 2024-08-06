import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/domain/repository/auth_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUc {
  final AuthRepository _authRepository;

  GetCurrentUserUc(this._authRepository);

  Future<DataState<UserData>> call() async {
    final result = await _authRepository.getCurrentUserData();
    return result.when(
      success: (data) {
        return DataState.success(
          data: UserData(
            firstName: data.displayName.split(' ').first,
            lastName: data.displayName.split(' ').last,
            email: data.email,
            isEmailVerified: data.emailVerified,
            id: data.uid,
          ),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(message: message);
      },
    );
  }
}
