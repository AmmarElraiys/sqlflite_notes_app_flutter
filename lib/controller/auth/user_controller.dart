// import 'package:get/get.dart';
// import 'package:notes_app/models/auth/userm_model.dart';
// import 'package:notes_app/services/sttings_services.dart';

// class UserController extends GetxController {
//   Rx<UserModel?> user = Rx<UserModel?>(null);

//   // Bu metodu login olduktan sonra çağırabilirsin
//   void loadUserData() {
//     final prefs = Get.find<SttingsServices>().sharedPreferences;
//     final name = prefs.getString("username");
//     final email = prefs.getString("email");

//     print("Loaded name: $name, email: $email");

//     if (name != null && email != null) {
//       user.value = UserModel(name: name, email: email);
//     }
//   }
// }
