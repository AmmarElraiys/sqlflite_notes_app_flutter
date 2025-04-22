import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';
import 'package:notes_app/screens/auth/login_screen.dart';
import 'package:notes_app/services/sttings_services.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  Future<List<Map<String, dynamic>>> _getUserData() async {
    return await NoteAppDatabase().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No user found."));
            }

            final user = snapshot.data![0];
            final username = user['username'];
            final email = user['email'];

            return ListView(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "assets/images/boy.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(username),
                        subtitle: Text(email),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                ListTile(title: Text("Home"), trailing: Icon(Icons.home)),
                ListTile(
                  title: Text("Language"),
                  trailing: Icon(Icons.language),
                ),
                ListTile(
                  title: Text("Settings"),
                  trailing: Icon(Icons.settings),
                ),
                ListTile(
                  trailing: Icon(Icons.exit_to_app),
                  title: Text("Sign Out"),
                  onTap: () {
                    Get.defaultDialog(
                      title: "Sign Out",
                      middleText: "Are you sure you want to sign out?",
                      textConfirm: "Yes",
                      textCancel: "No",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.find<SettingsServices>().logout();
                        Get.offAll(() => LoginScreen());
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
