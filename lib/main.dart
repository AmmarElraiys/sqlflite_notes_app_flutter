import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/auth/login_screen.dart';
// import 'package:notes_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: 'Flutter Demo', home: LoginScreen());
  }
}
