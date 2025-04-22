import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/home/home_controller.dart';
import 'package:notes_app/screens/home/group_add_notes_screen.dart';
import 'package:notes_app/widgets/drawer_home.dart';
import 'package:notes_app/widgets/home/deletegroupdialog_home_widget.dart';
import 'package:notes_app/widgets/home/floatingactionbutton_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      drawer: DrawerHome(),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Get.to(() => GroupAddNotesScreen(userId: controller.userId));
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: controller.groups.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 2,
            ),
            itemBuilder: (context, index) {
              final group = controller.groups[index];
              final groupName = group['groupname'];

              return GroupCard(
                group: group,
                groupName: groupName,
                controller: controller,
              );
            },
          ),
        );
      }),
    );
  }
}

class GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;
  final String groupName;
  final HomeController controller;

  const GroupCard({
    Key? key,
    required this.group,
    required this.groupName,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Grup tıklama işlemi.
          Get.toNamed("/notes", arguments: {"groupId": group['id']});
        },
        onLongPress: () {
          // Show confirmation dialog when long pressed
          showDialog(
            context: context,
            builder: (context) => DeleteGroupDialog(group: group),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/folder.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                groupName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
