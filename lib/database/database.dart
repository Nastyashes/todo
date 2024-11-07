import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/screen/home_screen/widget/notes.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateNoteCompletion(String noteId, bool isCompleted) async {
    try {
      await _db.collection('notes').doc(noteId).update({
        'isCompleted': isCompleted,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNewNote(Notes note) async {
    try {
      DocumentReference docRef =
          await _db.collection('notes').add(note.toMap());

      await docRef.update({'id': docRef.id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _db.collection('notes').doc(noteId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Notes>> getNotes({String? userId, bool? isCompleted}) {
    return _db
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Notes.fromFirestore(doc.id, doc.data()))
          .toList();
    });
  }
}
