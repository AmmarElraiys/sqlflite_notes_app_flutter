import 'package:flutter/material.dart';
import 'package:notes_app/controller/home/group_add_notes_controller.dart';

class GroupAddNotesScreen extends StatefulWidget {
  final int userId;

  const GroupAddNotesScreen({super.key, required this.userId});

  @override
  State<GroupAddNotesScreen> createState() => _GroupAddNotesScreenState();
}

class _GroupAddNotesScreenState extends State<GroupAddNotesScreen> {
  final GroupAddNotesController _controller = GroupAddNotesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Grup Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller.groupNameController,
              decoration: const InputDecoration(
                labelText: "Grup Adı",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _controller.addGroupNote(widget.userId, context),
              icon: const Icon(Icons.add),
              label: const Text("Grup Ekle"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
