import 'package:fanitek_test/presentation/forgot_password/forgot_password_binding.dart';
import 'package:fanitek_test/presentation/forgot_password/forgot_password_view.dart';
import 'package:fanitek_test/presentation/home/home_binding.dart';
import 'package:fanitek_test/presentation/home/home_view.dart';
import 'package:fanitek_test/presentation/login/login_binding.dart';
import 'package:fanitek_test/presentation/login/login_view.dart';
import 'package:fanitek_test/presentation/onboarding/auth_middleware.dart';
import 'package:fanitek_test/presentation/onboarding/onboarding_binding.dart';
import 'package:fanitek_test/presentation/onboarding/onboarding_view.dart';
import 'package:fanitek_test/presentation/profile/profile_binding.dart';
import 'package:fanitek_test/presentation/profile/profile_view.dart';
import 'package:fanitek_test/presentation/register/register_binding.dart';
import 'package:fanitek_test/presentation/register/register_view.dart';
import 'package:fanitek_test/presentation/reset_email/reset_email_binding.dart';
import 'package:fanitek_test/presentation/reset_email/reset_email_view.dart';
import 'package:fanitek_test/presentation/reset_password/reset_password_binding.dart';
import 'package:fanitek_test/presentation/reset_password/reset_password_view.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static const initial = Routes.ONBOARDING;
  static final routes = [
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      transition: Transition.rightToLeftWithFade,
      binding: OnboardingBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      transition: Transition.rightToLeftWithFade,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      transition: Transition.rightToLeftWithFade,
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      transition: Transition.rightToLeftWithFade,
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      transition: Transition.rightToLeftWithFade,
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      transition: Transition.rightToLeftWithFade,
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: Routes.RESET_EMAIL,
      page: () => const ResetEmailView(),
      transition: Transition.rightToLeftWithFade,
      binding: ResetEmailBinding(),
    ),
  ];
}
