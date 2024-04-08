
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/data_model.dart';
import 'package:hive/hive.dart';


ValueNotifier<List<NotesModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(NotesModel value) async {
  final studentdb = await Hive.openBox<NotesModel>('notes_db');
  await studentdb.add(value);
   getAllStudents();
}

Future<void> getAllStudents() async {
  final studentdb = await Hive.openBox<NotesModel>('notes_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentdb.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentdb = await Hive.openBox<NotesModel>('notes_db');
  studentdb.deleteAt(index);
  getAllStudents();

}
void editstudent(index,NotesModel value) async {
  final studentdb = await Hive.openBox<NotesModel>('notes_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentdb.values);
  studentdb.putAt(index, value);
}
