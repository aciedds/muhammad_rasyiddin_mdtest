import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isEmailVerified;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isEmailVerified,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
