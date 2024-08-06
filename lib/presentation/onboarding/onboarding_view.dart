import 'package:fanitek_test/presentation/onboarding/onboarding_controller.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.LOGIN),
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
