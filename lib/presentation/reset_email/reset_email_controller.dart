import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/domain/usecase/logout_uc.dart';
import 'package:fanitek_test/domain/usecase/update_email_uc.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetEmailController extends GetxController {
  final UpdateEmailUc updateEmailUc = inject<UpdateEmailUc>();
  final LogoutUc logoutUc = inject<LogoutUc>();

  late TextEditingController oldEmailTEC;
  late FocusNode oldEmailFN;

  late TextEditingController newEmailTEC;
  late FocusNode newEmailFN;

  late TextEditingController passwordTEC;
  late FocusNode passwordFN;

  String id = '';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as String?;
    if (args != null) {
      id = args;
    }
    initializeOldEmailTextField();
    initializePasswordTextField();
    initializeNewEmailTextField();
  }

  void initializeOldEmailTextField() {
    oldEmailTEC = TextEditingController();
    oldEmailFN = FocusNode();
  }

  void initializePasswordTextField() {
    passwordTEC = TextEditingController();
    passwordFN = FocusNode();
  }

  void initializeNewEmailTextField() {
    newEmailTEC = TextEditingController();
    newEmailFN = FocusNode();
  }

  @override
  void dispose() {
    oldEmailTEC.dispose();
    oldEmailFN.dispose();

    passwordTEC.dispose();
    passwordFN.dispose();

    newEmailTEC.dispose();
    newEmailFN.dispose();
    super.dispose();
  }

  void updatePassword() async {
    if (newEmailTEC.text != oldEmailTEC.text) {
      final result = await updateEmailUc.call(
        id: id,
        newEmail: newEmailTEC.text,
        password: passwordTEC.text,
      );
      result.when(
        success: (data) async {
          Get.snackbar("Success change email", "please login again");
          await logoutUc.call();
          Get.offAllNamed(Routes.ONBOARDING);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          Get.snackbar("Failed update email", message);
        },
      );
    }
  }
}
