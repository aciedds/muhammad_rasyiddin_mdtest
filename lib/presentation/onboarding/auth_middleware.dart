import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final FirebaseAuth auth = inject<FirebaseAuth>();

  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const RouteSettings(name: Routes.HOME);
    }
    return null;
  }
}
