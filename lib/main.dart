import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/middleware/auth_middleware.dart';
import 'package:notes_app/screens/auth/login_screen.dart';
import 'package:notes_app/screens/auth/passpword_screen.dart';
import 'package:notes_app/screens/auth/signup_screen.dart';
import 'package:notes_app/screens/home/add_notes_screen.dart';
import 'package:notes_app/screens/home/notes_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/services/sttings_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  intialService();
  runApp(const MyApp());
}

Future intialService() async {
  await Get.putAsync(() => SttingsServices().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: NotesScreen(),
      getPages: [
        GetPage(
          name: "/",
          page: () => LoginScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(name: "/signup", page: () => SignUpScreen()),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(name: "/password", page: () => ChangePasswordScreen()),
        GetPage(name: "/notes", page: () => NotesScreen()),
        GetPage(name: "/addnotes", page: () => AddNoteScreen()),
      ],
    );
  }
}
