import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';

class SignUpController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  RxBool isLoading = false.obs;

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

  Future<void> signUp() async {
    isLoading.value = true;

    String usernameText = username.text.trim();
    String emailText = email.text.trim();
    String phoneText = phone.text.trim();
    String passwordText = password.text.trim();

    // Check if fields are empty
    if (usernameText.isEmpty ||
        emailText.isEmpty ||
        phoneText.isEmpty ||
        passwordText.isEmpty) {
      Get.snackbar("Hata", "Tüm alanları doldurun");
      isLoading.value = false;
      return;
    }

    // Prepare data to insert
    Map<String, dynamic> user = {
      'username': usernameText,
      'email': emailText,
      'phone': phoneText,
      'password': passwordText,
    };

    // Insert user into database
    try {
      // Directly call the database instance without using .instance
      await NoteAppDatabase().insertUser(
        user,
      ); // Use the constructor instead of instance
      Get.snackbar("Başarılı", "Kayıt başarılı!");
    } catch (e) {
      Get.snackbar("Hata", "Bir hata oluştu: $e");
    }

    isLoading.value = false; // Stop loading after the operation
  }
}
