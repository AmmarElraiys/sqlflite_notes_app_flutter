import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/home/home_controller.dart';

class DeleteGroupDialog extends StatefulWidget {
  final Map<String, dynamic> group;
  final HomeController controller;

  const DeleteGroupDialog({
    Key? key,
    required this.group,
    required this.controller,
  }) : super(key: key);

  @override
  State<DeleteGroupDialog> createState() => _DeleteGroupDialogState();
}

class _DeleteGroupDialogState extends State<DeleteGroupDialog> {
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.warning_amber_rounded, color: Colors.red),
          SizedBox(width: 8),
          Text("Delete Group"),
        ],
      ),
      content: Text(
        'Are you sure you want to delete the group "${widget.group['groupname']}"?',
        style: const TextStyle(fontSize: 16),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions:
          isDeleting
              ? [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ]
              : [
                TextButton(
                  onPressed: () {
                    Get.back(); // Cancelled
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isDeleting = true;
                    });

                    await widget.controller.deleteGroup(widget.group['id']);

                    if (mounted) {
                      Get.back(); // Close dialog
                      Get.snackbar(
                        "Group Deleted",
                        '"${widget.group['groupname']}" has been deleted successfully.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.black87,
                        margin: const EdgeInsets.all(12),
                      );
                    }
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ],
    );
  }
}
