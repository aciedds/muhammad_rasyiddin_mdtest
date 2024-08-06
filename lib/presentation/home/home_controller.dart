import 'package:fanitek_test/di/injection.dart';
import 'package:fanitek_test/domain/entity/user/user_data.dart';
import 'package:fanitek_test/domain/usecase/get_current_user_uc.dart';
import 'package:fanitek_test/domain/usecase/get_list_user_uc.dart';
import 'package:fanitek_test/domain/usecase/get_user_data_uc.dart';
import 'package:fanitek_test/domain/usecase/logout_uc.dart';
import 'package:fanitek_test/domain/usecase/send_email_verification_uc.dart';
import 'package:fanitek_test/state/view_state/view_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeController extends GetxController {
  final GetCurrentUserUc getCurrentUserUc = inject<GetCurrentUserUc>();
  final GetUserDataUc getUserDataUc = inject<GetUserDataUc>();
  final LogoutUc logoutUc = inject<LogoutUc>();
  final SendEmailVerificationUc verifyEmailUc =
      inject<SendEmailVerificationUc>();
  final GetListUserUc getListUserUc = inject<GetListUserUc>();

  late RefreshController refreshController;
  late TextEditingController filterTEC;
  late FocusNode filterFN;

  Rx<ViewState<UserData>> userData = const ViewState<UserData>.initial().obs;
  Rx<ViewState<List<UserData>>> listUserData =
      const ViewState<List<UserData>>.initial().obs;

  RxBool isFiltered = false.obs;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    initializeFilterTextField();
    getUserData();
    getAllUser();
  }

  void initializeFilterTextField() {
    filterTEC = TextEditingController();
    filterFN = FocusNode();
  }

  void getUserData() async {
    userData.value = const ViewState.loading();
    final result = await getCurrentUserUc.call();
    result.when(success: (data) {
      userData.value = ViewState.success(data: data);
    }, error: (message, data, exception, stackTrace, statusCode) {
      userData.value = ViewState.error(message: message);
    });
  }

  void getAllUser({
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
  }) async {
    final result = await getListUserUc.call(
      firstName: firstName,
      lastName: lastName,
      email: email,
      isEmailVerified: isEmailVerified,
    );
    result.when(
      success: (data) {
        listUserData.value = ViewState.success(data: data);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        listUserData.value = ViewState.error(message: message);
      },
    );
  }

  void filterUsers() async {
    isFiltered.value = true;
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp emailRegExp = RegExp(emailPattern);

    String searchBy = filterTEC.text.trim();
    if (emailRegExp.hasMatch(searchBy)) {
      getAllUser(email: searchBy);
    } else if (searchBy.isNotEmpty) {
      getAllUser(firstName: searchBy, lastName: searchBy);
    } else {
      getAllUser();
    }
  }
}
