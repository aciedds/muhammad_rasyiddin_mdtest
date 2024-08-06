import 'package:fanitek_test/presentation/forgot_password/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            controller: controller.emailTEC,
            focusNode: controller.emailFN,
            decoration: const InputDecoration(
              hintText: "Email",
              label: Text("Email"),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: controller.forgotPassword,
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}
