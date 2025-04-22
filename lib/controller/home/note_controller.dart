import 'package:get/get.dart';
import 'package:notes_app/data/home/note_data.dart';

class NotesController extends GetxController {
  final int groupId;

  var isLoading = true.obs;
  var notes = <Map<String, dynamic>>[].obs;

  NotesController({required this.groupId});

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      isLoading.value = true;
      final db = NoteAppDatabase();
      final result = await db.getNotes(groupId);
      notes.assignAll(result);
    } catch (e) {
      Get.snackbar("Hata", "Notlar alınırken bir hata oluştu.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      final db = NoteAppDatabase();
      await db.deleteNote(id);
      await fetchNotes(); // Silme sonrası listeyi güncelle
    } catch (e) {
      Get.snackbar("Hata", "Not silinirken bir hata oluştu.");
    }
  }
}
