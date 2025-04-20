import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.onClose();
  }

  void signUp() {
    print("Username: ${username.text}");
    print("Email: ${email.text}");
    print("Phone: ${phone.text}");
    print("Password: ${password.text}");
    // buraya sign up işlemleri eklenecek
  }
}
