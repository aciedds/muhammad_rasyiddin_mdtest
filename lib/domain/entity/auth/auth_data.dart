import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_data.freezed.dart';

@freezed
class AuthData with _$AuthData {
  const factory AuthData({
    required String uid,
    required String email,
    required String displayName,
    required bool emailVerified,
    required bool isAnonymous,
    required List<String> providerIds,
    required String phoneNumber,
    required String creationTime,
    required String lastSignInTime,
  }) = _AuthData;
}
