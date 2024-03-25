import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/settings/settings_controller.dart';
import 'package:todolist/utils/appcolor.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.account_circle_rounded,
            color: AppColor.primaryColor,
          ),
          title: const Text('Profile'),
          subtitle: const Text('View and edit user profile'),
          onTap: () => {debugPrint('logout')},
        ),
        const Divider(height: 0),
        ListTile(
          leading: const Icon(
            Icons.power_settings_new,
            color: AppColor.primaryColor,
          ),
          title: const Text('Confirm action'),
          subtitle: Obx(() => Text(settingsController.getCurrentUsername())),
          onTap: () async => settingsController.logout(),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
