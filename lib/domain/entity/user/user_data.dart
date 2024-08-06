import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String firstName,
    required String lastName,
    required String email,
    required bool isEmailVerified,
    required String id,
  }) = _UserData;
}
