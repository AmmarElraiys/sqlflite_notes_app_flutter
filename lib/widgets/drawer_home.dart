import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/auth/login_screen.dart';
import 'package:notes_app/services/sttings_services.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
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
                    title: Text("AmmarElraiys"),
                    subtitle: Text("ammarelraiys@gmail.com"),
                  ),
                ),
              ],
            ),
            ListTile(title: Text("Home"), trailing: Icon(Icons.home)),
            ListTile(title: Text("language"), trailing: Icon(Icons.language)),
            ListTile(title: Text("setings"), trailing: Icon(Icons.settings)),

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
                    Get.find<SttingsServices>().logout();
                    Get.offAll(() => LoginScreen());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
