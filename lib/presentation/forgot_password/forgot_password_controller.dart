import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/domain/usecase/forgot_password_uc.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordUc forgotPasswordUc = inject<ForgotPasswordUc>();

  late TextEditingController emailTEC;
  late FocusNode emailFN;

  @override
  void onInit() {
    super.onInit();
    initializeEmailTextField();
  }

  void initializeEmailTextField() {
    emailTEC = TextEditingController();
    emailFN = FocusNode();
  }

  @override
  void dispose() {
    emailTEC.dispose();
    emailFN.dispose();
    super.dispose();
  }

  void forgotPassword() async {
    final email = emailTEC.text.trim();
    final result = await forgotPasswordUc.call(email: email);
    result.when(
      success: (data) => Get.offAllNamed(Routes.LOGIN),
      error: (message, data, exception, stackTrace, statusCode) =>
          Get.snackbar("Failed", message),
    );
  }
}
