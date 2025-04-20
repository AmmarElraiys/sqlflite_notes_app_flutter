import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/home/addnotes_controller.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final AddNotesController controller = Get.put(AddNotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                labelText: "title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Contents",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                    onPressed: controller.saveNote,
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                  );
            }),
          ],
        ),
      ),
    );
  }
}
