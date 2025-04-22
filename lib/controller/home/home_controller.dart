import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var user = <String, dynamic>{}.obs;
  var groups = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      final db = await NoteAppDatabase().db;
      await db.delete("notesgroup", where: "id = ?", whereArgs: [groupId]);
      groups.removeWhere((group) => group['id'] == groupId);
      Get.snackbar("Başarılı", "Grup başarıyla silindi.");
    } catch (e) {
      Get.snackbar("Hata", "Grup silinirken bir hata oluştu.");
    }
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading.value = true;

      // Fetch users
      final users = await NoteAppDatabase().getUsers();
      if (users.isEmpty) {
        Get.snackbar("Hata", "Kullanıcı bulunamadı.");
        return;
      }

      user.value = users[0]; // Assume we're using the first user
      final userId = user['id'];

      // Fetch groups for the user
      final db = await NoteAppDatabase().db;
      final groupData = await db.query(
        "notesgroup",
        where: "userid = ?",
        whereArgs: [userId],
      );

      groups.assignAll(groupData);
    } catch (e) {
      // Provide more specific error information
      Get.snackbar("Hata", "Veri alınırken bir hata oluştu: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int get userId {
    if (user.isNotEmpty && user.containsKey('id')) {
      return user['id'];
    }
    return -1; // Return a default invalid ID if user data is not available
  }
}
