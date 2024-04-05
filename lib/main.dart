import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/src/registration/registration_view.dart';
import 'package:todolist/src/settings/change_password/change_password_view.dart';
import 'package:todolist/src/settings/profile/profile_view.dart';
import 'package:todolist/src/task/create_task/create_task_view.dart';
import 'package:todolist/src/task/home_page_view.dart';
import 'package:todolist/utils/notification.dart';
import 'package:todolist/src/task/notification/notification_view.dart';

import 'src/login/login_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp(
    isFirstTime: await isFirstTimeOpening(),
  ));
}

Future<bool> isFirstTimeOpening() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? refresh = await storage.read(key: 'refresh');
  if (refresh != null && refresh.isNotEmpty) {
    return false;
  } else {
    return true;
  }
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    CustomNotification.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'TodoList',
      initialRoute: widget.isFirstTime ? '/login' : '/',
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
        ),
        GetPage(
          name: '/change-password',
          page: () => ChangePasswordView(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/notification-screen',
          page: () => const NotificationView(),
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
