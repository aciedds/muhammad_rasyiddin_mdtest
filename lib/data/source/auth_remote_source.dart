import 'package:fanitek_test/data/model/auth_model/auth_model.dart';
import 'package:fanitek_test/state/data_state/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRemote {
  final FirebaseAuth _auth;

  AuthRemote(this._auth);

  Future<DataState<AuthModel>> loginWithAuthEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return DataState.success(
        data: AuthModel.fromFirebaseUser(userCredential.user!),
      );
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<AuthModel>> registerWithAuthEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return DataState.success(
        data: AuthModel.fromFirebaseUser(userCredential.user!),
      );
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> logout() async {
    try {
      return await _auth
          .signOut()
          .then((value) => const DataState.success(data: true));
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> deleteUser() async {
    try {
      await _auth.currentUser!.delete();
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    try {
      await _auth.currentUser!.reload();
      final credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: password,
      );
      final result =
          await _auth.currentUser!.reauthenticateWithCredential(credential);
      await result.user!.verifyBeforeUpdateEmail(newEmail);
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _auth.currentUser!.reload();
      final credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );
      final result =
          await _auth.currentUser!.reauthenticateWithCredential(credential);
      await result.user!.updatePassword(newPassword);
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> updateDisplayName(
      {required String displayName}) async {
    try {
      await _auth.currentUser!.updateDisplayName(displayName);
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<bool>> updatePhotoURL({required String photoURL}) async {
    try {
      await _auth.currentUser!.updatePhotoURL(photoURL);
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }

  Future<DataState<AuthModel>> getCurrentUserData() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.reload();
        return DataState.success(
          data: AuthModel.fromFirebaseUser(_auth.currentUser!),
        );
      }
      return const DataState.error(message: "Error: User is null");
    } catch (e) {
      return DataState.error(message: "Error: $e");
    }
  }
}
