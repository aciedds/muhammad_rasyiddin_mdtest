import 'package:fanitek_test/presentation/profile/profile_controller.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.offNamed(Routes.HOME),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 60,
            child: const Icon(
              Icons.person,
              size: 50,
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.isEditingName.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.firstNameTEC,
                    focusNode: controller.firstNameFN,
                    decoration: const InputDecoration(
                      hintText: "First name",
                      label: Text("First name"),
                    ),
                  ),
                  TextField(
                    controller: controller.lastNameTEC,
                    focusNode: controller.lastNameFN,
                    decoration: const InputDecoration(
                      hintText: "Last name",
                      label: Text("Last name"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.updateProfile,
                    child: const Text("Update Profile"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.offNamed(Routes.RESET_PASSWORD),
                    child: const Text("Reset Password"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.offNamed(
                      Routes.RESET_EMAIL,
                      arguments: controller.id.value,
                    ),
                    child: const Text("Reset Email"),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text("Name:"),
                    const SizedBox(width: 10),
                    Text(
                      "${controller.firstName.value} ${controller.lastName.value}",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Email: "),
                    const SizedBox(width: 10),
                    Text(controller.email.value),
                    const SizedBox(width: 10),
                    controller.isEmailVerified.value
                        ? Icon(
                            Icons.verified,
                            color: Theme.of(context).primaryColor,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.isEditingName.value = true;
                  },
                  child: const Text("Edit Profile"),
                ),
                controller.isEmailVerified.value
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        onPressed: controller.verifyEmail,
                        child: const Text("Verify Email"),
                      ),
              ],
            );
          }),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: controller.logout,
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
