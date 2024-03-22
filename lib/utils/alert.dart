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

  Widget showConnectionError(Function retryFn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fatal_error.png'),
            ),
          ),
        ),
         const Padding(
          padding: EdgeInsets.only(top:8.0),
          child: Text(
            "Connection Failed !",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Text("Please try again later"),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: FilledButton(
            onPressed: ()=>retryFn(),
            child: const Text("Retry"),
          ),
        ),
      ],
    );
  }
}
