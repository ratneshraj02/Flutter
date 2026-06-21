import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/utils/show_messages.dart';

class NoteProvider extends ChangeNotifier {
  FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

  List<NoteModel> notes = [];

  void getNote() async {
    notes.clear();
    _isLoading(true);
    try {
      _isLoading(true);
      final result = await firestoreDB
          .collection('notes')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();
      for (var doc in result.docs) {
        NoteModel note = NoteModel.fromMap(doc.data());
        notes.add(note);
      }
    } on FirebaseException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _isLoading(false);
    }
  }

  void addNote(String title, String description) async {
    _isLoading(true);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      NoteModel note = NoteModel(
        id,
        auth.currentUser!.uid,
        title,
        description,
        DateTime.now(),
      );
      await firestoreDB.collection('notes').doc(id).set(note.toMap());
      getNote();
      Navigator.pop(navigatorKey.currentContext!);
    } on FirebaseException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _isLoading(false);
    }
  }

  void deleteNote(NoteModel note) async {
    try {
      _isLoading(true);
      await firestoreDB.collection('notes').doc(note.id).delete();
      getNote();
    } on FirebaseException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _isLoading(false);
    }
  }

  void updateNote(String title, String description, String noteId) async {
    try {
      _isLoading(true);
      await firestoreDB.collection('notes').doc(noteId).update({
        'title': title,
        'description': description,
      });
      getNote();
      Navigator.pop(navigatorKey.currentContext!);
    } on FirebaseException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _isLoading(false);
    }
  }

  _isLoading(value) {
    loading = value;
    notifyListeners();
  }
}
