import 'package:flutter/material.dart';
import 'package:notes_app/controller/home/group_add_notes_controller.dart';
import 'package:notes_app/widgets/auth/button_login_signup_widget.dart';
import 'package:notes_app/widgets/auth/textformfield_widget.dart';

class GroupAddNotesScreen extends StatefulWidget {
  final int? userId;

  const GroupAddNotesScreen({super.key, this.userId});

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
      appBar: AppBar(title: const Text("Add New Group")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormFieldWidget(
              label: "Group Name",
              icon: Icons.folder,

              controller: _controller.groupNameController,
            ),

            const SizedBox(height: 20),
            ButtonLoginSignupWidget(
              text: "Group Add",
              onPressed:
                  () => _controller.addGroupNote(widget.userId!, context),
            ),
          ],
        ),
      ),
    );
  }
}
