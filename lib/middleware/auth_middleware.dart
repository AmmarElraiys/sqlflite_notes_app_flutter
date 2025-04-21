import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/services/sttings_services.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  final SttingsServices controller = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final roul = controller.sharedPreferences.getString("roul");

    if (roul == "0") {
      return const RouteSettings(name: "/home");
    }

    return null;
  }
}
