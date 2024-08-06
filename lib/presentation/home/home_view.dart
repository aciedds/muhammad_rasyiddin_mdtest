import 'package:fanitek_test/presentation/home/home_controller.dart';
import 'package:fanitek_test/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.filterTEC,
                              focusNode: controller.filterFN,
                              decoration:
                                  const InputDecoration(hintText: "Search"),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.filterUsers();
                              controller.filterTEC.clear();
                              controller.filterFN.unfocus();
                              Get.back();
                            },
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text("Filter by:"),
                      TextButton(
                        onPressed: () {
                          controller.isFiltered.value = true;
                          controller.getAllUser(isEmailVerified: true);
                          Get.back();
                        },
                        child: const Text("Verified Email"),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.sort),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => Get.offNamed(Routes.PROFILE),
        ),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () {
          controller.getAllUser();
          controller.isFiltered.value = false;
          controller.refreshController.refreshCompleted();
        },
        onLoading: () {
          controller.getAllUser();
          controller.isFiltered.value = false;
          controller.refreshController.loadComplete();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return controller.userData.value.maybeWhen(
                orElse: () => loadingCard(),
                success: (data) => Card(
                  margin: const EdgeInsets.only(right: 50, left: 8, top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        successCard(
                          context,
                          firstName: data.firstName,
                          lastName: data.lastName,
                          email: data.email,
                          isEmailVerified: data.isEmailVerified,
                        ),
                      ],
                    ),
                  ),
                ),
                error: (message) => errorCard(),
              );
            }),
            Obx(() {
              if (!controller.isFiltered.value) {
                return const SizedBox(
                  height: 10,
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Filtered",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }),
            Obx(() {
              return controller.listUserData.value.maybeWhen(
                orElse: () => loadingCard(),
                error: (message) => const SizedBox.shrink(),
                success: (data) => ListView.separated(
                  itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: successCard(
                        context,
                        firstName: data[index].firstName,
                        lastName: data[index].lastName,
                        email: data[index].email,
                        isEmailVerified: data[index].isEmailVerified,
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget successCard(
    BuildContext context, {
    required String firstName,
    required String lastName,
    required String email,
    required bool isEmailVerified,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$firstName $lastName",
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(email),
            isEmailVerified
                ? Icon(
                    Icons.verified,
                    size: 12,
                    color: Theme.of(context).primaryColor,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }

  Widget loadingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.white12,
              child: Container(
                width: 200.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.white12,
              child: Container(
                width: 200.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("-"),
            Text("-"),
          ],
        ),
      ),
    );
  }
}
