import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotesController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final isLoading = false.obs;

  void saveNote() {
    final String title = titleController.text.trim();
    final String content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("Hata", "Başlık ve içerik boş olamaz");
      return;
    }

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      final note = {
        "title": title,
        "content": content,
        "date": DateTime.now().toString().split(" ")[0],
      };

      isLoading.value = false;
      Get.back(result: note); // notu geri döndür
    });
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
