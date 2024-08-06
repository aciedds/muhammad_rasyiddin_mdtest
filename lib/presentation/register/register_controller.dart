import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/domain/usecase/register_uc.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RegisterUc registerUc = inject<RegisterUc>();

  late TextEditingController emailTEC;
  late FocusNode emailFN;

  late TextEditingController passwordTEC;
  late FocusNode passwordFN;

  late TextEditingController firstNameTEC;
  late FocusNode firstNameFN;

  late TextEditingController lastNameTEC;
  late FocusNode lastNameFN;

  @override
  void onInit() {
    super.onInit();
    initializeEmailTextField();
    initializePasswordTextField();
    initializeFirstNameTextField();
    initializeLastNameTextField();
  }

  void initializeEmailTextField() {
    emailTEC = TextEditingController();
    emailFN = FocusNode();
  }

  void initializePasswordTextField() {
    passwordTEC = TextEditingController();
    passwordFN = FocusNode();
  }

  void initializeFirstNameTextField() {
    firstNameTEC = TextEditingController();
    firstNameFN = FocusNode();
  }

  void initializeLastNameTextField() {
    lastNameTEC = TextEditingController();
    lastNameFN = FocusNode();
  }

  @override
  void dispose() {
    emailTEC.dispose();
    emailFN.dispose();
    passwordTEC.dispose();
    passwordFN.dispose();
    firstNameTEC.dispose();
    firstNameFN.dispose();
    lastNameTEC.dispose();
    lastNameFN.dispose();
    super.dispose();
  }

  void register() async {
    final result = await registerUc.call(
      email: emailTEC.text,
      password: passwordTEC.text,
      firstName: firstNameTEC.text,
      lastName: lastNameTEC.text,
    );
    result.when(
      success: (data) => Get.offAllNamed(Routes.HOME),
      error: (message, data, exception, stackTrace, statusCode) =>
          Get.snackbar("Error", message),
    );
  }
}
