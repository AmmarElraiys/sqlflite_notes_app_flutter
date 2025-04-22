import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';

class GroupAddNotesController {
  final TextEditingController groupNameController = TextEditingController();

  Future<void> addGroupNote(int userId, BuildContext context) async {
    final db = await NoteAppDatabase().db;
    String groupName = groupNameController.text.trim();

    if (groupName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Group name cannot be empty")),
      );
      return;
    }

    int insertgroup = await db.insert("notesgroup", {
      "userid": userId,
      "groupname": groupName,
    });
    print(insertgroup);

    Get.offNamed("/home");
    Get.reset();
  }

  void dispose() {
    groupNameController.dispose();
  }
}
