import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/domain/repository/user_repository.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetListUserUc {
  final UserRepository _userRepository;

  GetListUserUc(this._userRepository);

  Future<DataState<List<UserData>>> call({
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
  }) async {
    return await _userRepository.getListUserData(
      firstName: firstName,
      lastName: lastName,
      email: email,
      isEmailVerified: isEmailVerified,
    );
  }
}
