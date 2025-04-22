import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';
import 'package:notes_app/services/sttings_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  RxBool isLoading = false.obs;
  SharedPreferences? sharedPreferences;
  final SettingsServices settings = Get.put(SettingsServices());
  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  Future<bool> login() async {
    isLoading.value = true;

    String emailText = email.text.trim();
    String passwordText = password.text.trim();

    if (emailText.isEmpty || passwordText.isEmpty) {
      Get.snackbar("Hata", "Email ve şifre boş olamaz");
      isLoading.value = false;
      return false;
    }

    try {
      final db = await NoteAppDatabase().db;

      final List<Map<String, dynamic>> result = await db.query(
        "users",
        where: "email = ? AND password = ?",
        whereArgs: [emailText, passwordText],
      );

      if (result.isNotEmpty) {
        Get.snackbar("Giriş Başarılı", "Hoş geldiniz!");
        isLoading.value = false;
        return true; // Giriş başarılı
      } else {
        Get.snackbar("Hata", "Geçersiz email veya şifre");
        isLoading.value = false;
        return false; // Giriş başarısız
      }
    } catch (e) {
      // Get.snackbar("Hata", "Bir hata oluştu: $e");
      print(e);
      isLoading.value = false;
      return false; // Hata durumunda da false döndür
    }
  }

  void logout() {
    settings.logout(); // bu artık sharedPreferences.clear() çağırır
    Get.offAllNamed("/login"); // örnek olarak kullanıcıyı login ekranına gönder
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
