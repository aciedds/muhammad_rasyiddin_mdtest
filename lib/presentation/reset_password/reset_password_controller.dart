import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/domain/usecase/logout_uc.dart';
import 'package:fanitek_test/domain/usecase/update_password_uc.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final UpdatePasswordUc updatePasswordUc = inject<UpdatePasswordUc>();
  final LogoutUc logoutUc = inject<LogoutUc>();

  late TextEditingController oldPasswordTEC;
  late FocusNode oldPasswordFN;

  late TextEditingController passwordTEC;
  late FocusNode passwordFN;

  late TextEditingController confirmPasswordTEC;
  late FocusNode confirmPasswordFN;

  @override
  void onInit() {
    super.onInit();
    initializeOldPasswordTextField();
    initializePasswordTextField();
    initializeConfirmPasswordTextField();
  }

  void initializeOldPasswordTextField() {
    oldPasswordTEC = TextEditingController();
    oldPasswordFN = FocusNode();
  }

  void initializePasswordTextField() {
    passwordTEC = TextEditingController();
    passwordFN = FocusNode();
  }

  void initializeConfirmPasswordTextField() {
    confirmPasswordTEC = TextEditingController();
    confirmPasswordFN = FocusNode();
  }

  @override
  void dispose() {
    oldPasswordTEC.dispose();
    oldPasswordFN.dispose();

    passwordTEC.dispose();
    passwordFN.dispose();

    confirmPasswordTEC.dispose();
    confirmPasswordFN.dispose();
    super.dispose();
  }

  void updatePassword() async {
    if (passwordTEC.text == confirmPasswordTEC.text) {
      final result = await updatePasswordUc.call(
        newPassword: passwordTEC.text,
        currentPassword: oldPasswordTEC.text,
      );
      result.when(
        success: (data) async {
          Get.snackbar("Success change password", "please login again");
          await logoutUc.call();
          Get.offAllNamed(Routes.ONBOARDING);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          Get.snackbar("Failed update password", message);
        },
      );
    }
  }
}
