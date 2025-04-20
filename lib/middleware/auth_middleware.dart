import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/services/sttings_services.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  SttingsServices controller = Get.put(SttingsServices());

  @override
  RouteSettings? redirect(String? route) {
    final roul = controller.sharedPreferences.getString("roul");

    // örneğin "0" ise ana sayfaya yönlendir
    if (roul == "0") {
      return const RouteSettings(name: "/home");
    }

    // yönlendirme gerekmezse null döner
    return null;
  }
}
