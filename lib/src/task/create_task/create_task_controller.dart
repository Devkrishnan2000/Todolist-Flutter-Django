import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/api/apis.dart';
import 'package:todolist/src/task/create_task/create_task_model.dart';
import 'package:todolist/src/task/list/tasklist_controller.dart';
import 'package:todolist/utils/format.dart';
import 'package:todolist/utils/notification.dart';
import 'package:todolist/utils/snack_bar.dart';
import 'package:todolist/utils/validation.dart';

class CreateTaskController extends GetxController {
  var createTaskFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var pendingListController = Get.find<TaskListController>(tag: "pending");
  DateTime? datetime;
  var datetimeButtonLabel = "Set date and time".obs;
  var isLoading = false.obs;
  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  String? validateTitle(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.minFourCharactersValidation(value)) {
      return Validation.minimum4CharacterValidationMsg;
    } else {
      return null;
    }
  }

  String? validateDesc(String? value) {
    if (Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.minFourCharactersValidation(value)) {
      return Validation.minimum4CharacterValidationMsg;
    } else {
      return null;
    }
  }

  void selectDateAndTime(BuildContext context) async {
    var selectedDate = await selectDate(context);
    if (context.mounted) {
      if (selectedDate != null) {
        var selectedTime = await selectTime(context);
        if (selectedTime != null) {
          datetime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          debugPrint(datetime.toString());
          datetimeButtonLabel.value = Format().formatDate(datetime!);
        } else {
          datetime = null;
        }
      }
    }
  }

  void createTask() async {
    if (createTaskFormKey.currentState!.validate()) {
      if (datetime != null) {
        if (datetime!.compareTo(DateTime.now()) >= 0) {
          CreateTask data =
              CreateTask(titleController.text, descController.text, datetime!);
          isLoading.value = true;
          dio.Response? response = await TaskAPI().createTask(data.toJSON());
          if (response?.statusCode == 201) {
            await CustomNotification.setTaskNotification(
              id: response?.data['task_id'],
              title: data.title,
              body: data.description,
              datetime: data.date,
            );
            Get.back();
            await pendingListController.loadList(
                url: '/tasks/list/?completed=False');
            CustomSnackBar.showSuccessSnackBar("Successful", "Task Created !");
          } else {
            CustomSnackBar.showErrorSnackBar(
                "Server error", "Please try again later");
          }
        } else {
          CustomSnackBar.showErrorSnackBar(
              "Invalid time", "Please provide a future time");
        }
      } else {
        CustomSnackBar.showErrorSnackBar(
            "Attention", "Please set date and time");
      }
      isLoading.value = false;
    }
  }

  Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5));

  Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
}
