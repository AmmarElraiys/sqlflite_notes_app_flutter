import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SttingsServices extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<SttingsServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}
