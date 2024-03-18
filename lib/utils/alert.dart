import 'package:flutter/material.dart';
import 'package:todolist/utils/appcolor.dart';

class Alert {
  Future show(BuildContext context, String title, String message) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: AppColor.cardColor,
              elevation: 0,
              title: Center(
                  child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              contentPadding: const EdgeInsets.all(20),
              children: [
                Center(child: Text(message)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                )
              ],
            ));
  }
}
