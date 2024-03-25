import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/settings/Profile/profile_controller.dart';
import 'package:todolist/src/settings/settings_controller.dart';
import 'package:todolist/utils/appbar.dart';
import 'package:todolist/utils/text_style.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final settingsController = Get.find<SettingsController>();
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    settingsController.retryGetUserDetails();
    return Scaffold(
        appBar: CustomAppBar.show(heading: "My Profile"),
        body: Obx(() => ListView(
              children: [
                ListTile(
                  title: Text(
                    'Name',
                    style: CustomTextStyle.subHeading1(),
                  ),
                  subtitle: Text(settingsController.user.value.name),
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'Email',
                    style: CustomTextStyle.subHeading1(),
                  ),
                  subtitle: Text(settingsController.user.value.email),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: FilledButton(
                      onPressed: () =>
                          profileController.updateUserDetailsDialog(),
                      child: const Text(
                        "Update Details",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                )
              ],
            )));
  }
}
