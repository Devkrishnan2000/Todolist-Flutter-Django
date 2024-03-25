import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/registration/registration_view.dart';
import 'package:todolist/src/settings/Profile/profile_view.dart';
import 'package:todolist/src/task/create_task/create_task_view.dart';
import 'package:todolist/src/task/home_page_view.dart';
import 'src/login/login_view.dart';

void main() async {
  runApp(MyApp(
    isFirstTime: await isFirstTimeOpening(),
  ));
}

Future<bool> isFirstTimeOpening() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? refresh = await storage.read(key: 'refresh');
  if (refresh!.isNotEmpty) {
    return false;
  } else {
    return true;
  }
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoList',
      initialRoute: isFirstTime ? '/login' : '/',
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
        GetPage(
          name: '/profile',
          page: () => ProfileView(),
          transition: Transition.rightToLeft,
        )
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
