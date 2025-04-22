import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/home/home_controller.dart';

class DeleteGroupDialog extends StatelessWidget {
  final Map<String, dynamic> group;
  final HomeController controller;

  const DeleteGroupDialog({
    Key? key,
    required this.group,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmation of Deletion"),
      content: Text("${group['groupname']} Do you want to delete the group?"),
      actions: [
        TextButton(
          onPressed: () async {
            // If user confirms, delete the group
            await controller.deleteGroup(group['id']);
            Get.back(); // Close the dialog
          },
          child: const Text("Yes"),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text("NO"),
        ),
      ],
    );
  }
}
