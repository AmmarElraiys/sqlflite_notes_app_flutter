import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/home/note_controller.dart';
import 'package:notes_app/widgets/home/floatingactionbutton_widget.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final int groupId = Get.arguments["groupId"];

  @override
  Widget build(BuildContext context) {
    // Controller'ı burada inject et
    final NotesController controller = Get.put(
      NotesController(groupId: groupId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Notes Page")),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Get.toNamed("/addnotes", arguments: {"id": groupId})?.then((_) {
            controller.fetchNotes(); // Yeni not eklenince listeyi güncelle
          });
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notes.isEmpty) {
          return const Center(child: Text("No notes  found "));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: Text(
                  note["title"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(note["date"] ?? ""),
                leading: const Icon(Icons.note, color: Colors.blueAccent),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    controller.deleteNote(note["id"]);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
