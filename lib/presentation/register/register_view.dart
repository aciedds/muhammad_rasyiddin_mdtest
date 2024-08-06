import 'package:fanitek_test/presentation/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            controller: controller.firstNameTEC,
            focusNode: controller.firstNameFN,
            decoration: const InputDecoration(
              hintText: "First Name",
              label: Text("First Name"),
            ),
          ),
          TextField(
            controller: controller.lastNameTEC,
            focusNode: controller.lastNameFN,
            decoration: const InputDecoration(
              hintText: "Last Name",
              label: Text("Last Name"),
            ),
          ),
          TextField(
            controller: controller.emailTEC,
            focusNode: controller.emailFN,
            decoration: const InputDecoration(
              hintText: "Email",
              label: Text("Email"),
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
          ElevatedButton(
            onPressed: controller.register,
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
