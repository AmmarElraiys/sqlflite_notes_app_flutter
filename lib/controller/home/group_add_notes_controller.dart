import 'package:flutter/material.dart';
// import 'package:notes_app/database/noteapp_database.dart';

class GroupAddNotesController {
  final TextEditingController groupNameController = TextEditingController();

  Future<void> addGroupNote(int userId, BuildContext context) async {
    // final db = await NoteAppDatabase().db;
    String groupName = groupNameController.text.trim();

    if (groupName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Grup adı boş olamaz")));
      return;
    }

    // await db.insert("notesgroup", {
    //   "userid": userId,
    //   "groupname": groupName,
    // });

    Navigator.pop(context); // Ekleme sonrası geri dön
  }

  void dispose() {
    groupNameController.dispose();
  }
}
