import 'package:flutter/material.dart';

class Alert
{
   Future show(BuildContext context,String title,String message)
   {
    return showDialog(
         context: context,
         builder: (context) => SimpleDialog(
           title: Center(child: Text(title)),
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