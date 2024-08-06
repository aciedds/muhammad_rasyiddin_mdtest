import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/domain/usecase/get_current_user_uc.dart';
import 'package:fanitek_test/domain/usecase/logout_uc.dart';
import 'package:fanitek_test/domain/usecase/send_email_verification_uc.dart';
import 'package:fanitek_test/domain/usecase/update_first_name_last_name_uc.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final LogoutUc logoutUc = inject<LogoutUc>();
  final SendEmailVerificationUc verifyEmailUc =
      inject<SendEmailVerificationUc>();
  final UpdateFirstNameLastNameUc updateFirstNameLastNameUc =
      inject<UpdateFirstNameLastNameUc>();
  final GetCurrentUserUc getCurrentUserUc = inject<GetCurrentUserUc>();

  late TextEditingController firstNameTEC;
  late FocusNode firstNameFN;
  late TextEditingController lastNameTEC;
  late FocusNode lastNameFN;

  RxBool isEditingName = false.obs;

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString imageUrl = ''.obs;
  RxString email = ''.obs;
  RxBool isEmailVerified = false.obs;
  RxString id = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as UserData?;
    if (args != null) {
      firstName.value = args.firstName;
      lastName.value = args.lastName;
      email.value = args.email;
      isEmailVerified.value = args.isEmailVerified;
      id.value = args.id;
    } else {
      getProfile();
    }
    initializeFirstNameTexField();
    initializeLastNameTextField();
  }

  void initializeFirstNameTexField() {
    firstNameTEC = TextEditingController();
    firstNameFN = FocusNode();
  }

  void initializeLastNameTextField() {
    lastNameTEC = TextEditingController();
    lastNameFN = FocusNode();
  }

  @override
  void dispose() {
    firstNameTEC.dispose();
    firstNameFN.dispose();
    lastNameTEC.dispose();
    lastNameFN.dispose();
    isEditingName.value = false;
    super.dispose();
  }

  void logout() async {
    final result = await logoutUc.call();
    result.when(
      success: (data) => Get.offAllNamed(Routes.ONBOARDING),
      error: (message, data, exception, stackTrace, statusCode) =>
          Get.snackbar("Error", message),
    );
  }

  void updateProfile() async {
    final result = await updateFirstNameLastNameUc.call(
      firstName: editedFirstName,
      lastName: editedLastName,
      id: id.value,
    );
    result.when(
      success: (data) {
        Get.snackbar("Success", "Success Edit Profile");
        Get.offNamed(Routes.HOME);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        Get.snackbar("Failed update profile", message);
      },
    );
  }

  void verifyEmail() async {
    final result = await verifyEmailUc.call(id.value);
    result.when(
      success: (data) => Get.snackbar("Success", "Please check your email"),
      error: (message, data, exception, stackTrace, statusCode) =>
          Get.snackbar("Failed", message),
    );
  }

  void getProfile() async {
    final result = await getCurrentUserUc.call();
    result.when(
      success: (data) {
        firstName.value = data.firstName;
        lastName.value = data.lastName;
        email.value = data.email;
        isEmailVerified.value = data.isEmailVerified;
        id.value = data.id;
      },
      error: (message, data, exception, stackTrace, statusCode) {
        Get.snackbar("Error", message);
      },
    );
  }

  String get editedFirstName {
    if (firstNameTEC.text.trim().isEmpty) {
      return firstName.value;
    }
    return firstNameTEC.text.trim();
  }

  String get editedLastName {
    if (lastNameTEC.text.trim().isEmpty) {
      return lastName.value;
    }
    return lastNameTEC.text.trim();
  }
}
