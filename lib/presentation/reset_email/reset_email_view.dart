import 'package:fanitek_test/presentation/reset_email/reset_email_controller.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetEmailView extends GetView<ResetEmailController> {
  const ResetEmailView({super.key});

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
            controller: controller.oldEmailTEC,
            focusNode: controller.oldEmailFN,
            decoration: const InputDecoration(
              hintText: "Old Email",
              label: Text("Old Email"),
            ),
          ),
          TextField(
            controller: controller.newEmailTEC,
            focusNode: controller.newEmailFN,
            decoration: const InputDecoration(
              hintText: "New Email",
              label: Text("New Email"),
            ),
          ),
          TextField(
            controller: controller.passwordTEC,
            focusNode: controller.passwordFN,
            decoration: const InputDecoration(
              hintText: "Password",
              label: Text("Password"),
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
