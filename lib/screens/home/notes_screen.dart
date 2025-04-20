import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/widgets/home/floatingactionbutton_widget.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek veri
    final notes = [
      {"title": "Note One", "date": "10/2/2025"},
      {"title": "Note Two", "date": "11/2/2025"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Notes Page")),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Get.toNamed("/addnotes");
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
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
                note["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(note["date"]!),
              leading: const Icon(Icons.note, color: Colors.blueAccent),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  // Silme işlemi
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
