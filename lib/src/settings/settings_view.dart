import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/settings/settings_controller.dart';
import 'package:todolist/utils/appcolor.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    settingsController.retryGetUserDetails();
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.account_circle_rounded,
            color: AppColor.primaryColor,
          ),
          title: const Text('Profile'),
          subtitle: const Text('View and edit user profile'),
          onTap: () => Get.toNamed('/profile'),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(
            Icons.password_rounded,
            color: AppColor.primaryColor,
          ),
          title: const Text('Change password'),
          subtitle: const Text('Change your Todolist account password'),
          onTap: () => Get.toNamed("/change-password"),
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(
            Icons.power_settings_new,
            color: AppColor.primaryColor,
          ),
          title: const Text('Log out'),
          subtitle: Obx(() => Text(settingsController.getCurrentUsername())),
          onTap: () async => settingsController.logout(),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
