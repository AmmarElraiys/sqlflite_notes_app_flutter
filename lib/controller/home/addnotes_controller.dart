import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';

class AddNotesController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final isLoading = false.obs;

  late final int groupId;

  @override
  void onInit() {
    super.onInit();

    // Argument ile gelen groupId'yi al
    if (Get.arguments != null && Get.arguments['id'] != null) {
      groupId = Get.arguments['id'];
    } else {
      Get.snackbar("Hata", "Grup ID bulunamadı.");
      groupId = -1; // geçersiz ID
    }
  }

  Future<void> saveNote() async {
    if (groupId == -1) return; // Geçersizse işlem yapma

    final String title = titleController.text.trim();
    final String content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("Hata", "Başlık ve içerik boş olamaz");
      return;
    }

    isLoading.value = true;

    final note = {
      "groupid": groupId,
      "title": title,
      "contents": content,
      "date": DateTime.now().toString().split(" ")[0],
    };

    try {
      final dbHelper = NoteAppDatabase();
      final insertedId = await dbHelper.insertNote(note);
      print("Not eklendi: $insertedId");
      Get.back(result: note); // Sayfaya geri dön, notu da gönder
    } catch (e) {
      Get.snackbar("Hata", "Not kaydedilemedi.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
