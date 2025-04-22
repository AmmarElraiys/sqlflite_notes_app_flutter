import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/services/sttings_services.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final settingsServices = Get.find<SettingsServices>();
    final role = settingsServices.sharedPreferences.getString("role");

    if (role != null) {
      return const RouteSettings(name: "/home");
    }

    return null; // giriş yapmamışsa devam etsin
  }
}
