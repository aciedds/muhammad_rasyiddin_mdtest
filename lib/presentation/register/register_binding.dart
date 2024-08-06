import 'package:fanitek_test/presentation/login/login_controller.dart';
import 'package:fanitek_test/presentation/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
