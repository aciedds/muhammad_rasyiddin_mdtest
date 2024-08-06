import 'package:fanitek_test/presentation/forgot_password/forgot_password_controller.dart';
import 'package:fanitek_test/presentation/login/login_controller.dart';
import 'package:fanitek_test/presentation/reset_email/reset_email_controller.dart';
import 'package:fanitek_test/presentation/reset_password/reset_password_controller.dart';
import 'package:get/get.dart';

class ResetEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetEmailController());
  }
}
