import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/registration/registration_view.dart';
import 'package:todolist/src/task/create_task/create_task_view.dart';
import 'package:todolist/src/task/home_page_view.dart';
import 'src/login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoList',
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          transition: Transition.circularReveal,
        ),
        GetPage(
          name: '/registration',
          page: () => const Registration(),
          transition: Transition.circularReveal,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          transition: Transition.circularReveal,
        ),
        GetPage(
          name: '/create_task',
          page: () => CreateTaskView(),
          transition: Transition.circularReveal,
        ),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1FAB89)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
