import 'package:fanitek_test/presentation/reset_password/reset_password_controller.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Passsword"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.offNamed(Routes.PROFILE)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            controller: controller.oldPasswordTEC,
            focusNode: controller.oldPasswordFN,
            decoration: const InputDecoration(
              hintText: "Old Password",
              label: Text("Old Password"),
            ),
          ),
          TextField(
            controller: controller.passwordTEC,
            focusNode: controller.passwordFN,
            decoration: const InputDecoration(
              hintText: "New Password",
              label: Text("New Password"),
            ),
          ),
          TextField(
            controller: controller.confirmPasswordTEC,
            focusNode: controller.confirmPasswordFN,
            decoration: const InputDecoration(
              hintText: "Confrim New Password",
              label: Text("Confrim New Password"),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: controller.updatePassword,
            child: const Text("Update password"),
          ),
        ],
      ),
    );
  }
}
