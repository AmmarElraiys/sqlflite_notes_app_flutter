import 'package:get/get.dart';
import 'package:notes_app/controller/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsServices extends GetxService {
  late SharedPreferences sharedPreferences;
  late final controller = Get.put(HomeController());
  Future<SettingsServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  void logout() async {
    await sharedPreferences.clear(); // Tüm verileri temizler
  }

  // İstersen bazı yardımcı metodlar da ekleyebilirsin:
  String? getUserRole() {
    return sharedPreferences.getString("role");
  }

  void setUserRole(String role) {
    sharedPreferences.setString("role", role);
  }
}
