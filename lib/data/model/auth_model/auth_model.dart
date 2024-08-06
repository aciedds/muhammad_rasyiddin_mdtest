import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(createFactory: false)
class AuthModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final bool? emailVerified;
  final bool? isAnonymous;
  final List<String>? providerIds;
  final String? phoneNumber;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;

  AuthModel({
    this.uid,
    this.email,
    this.displayName,
    this.emailVerified,
    this.isAnonymous,
    this.providerIds,
    this.phoneNumber,
    this.creationTime,
    this.lastSignInTime,
  });

  // Factory method to create a AuthCollectionModel object from a FirebaseUser
  factory AuthModel.fromFirebaseUser(User user) {
    return AuthModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      emailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      providerIds:
          user.providerData.map((provider) => provider.providerId).toList(),
      phoneNumber: user.phoneNumber,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
    );
  }

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
