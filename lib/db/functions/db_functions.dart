import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:student_details/db/model/data_model.dart';

class FunctionDB with ChangeNotifier {
  static List<StudentModel> studentList = [];
  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(value.id, value);
    log('Add Studetn');
    studentList.add(value);
    getAllStudent();
    notifyListeners();
  }

  Future<List<StudentModel>> getAllStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();

    studentList.addAll(studentDB.values);
    log('Get All Student in db');
    return studentList;
  }

  Future<void> deleteStudent(String id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    getAllStudent();
    notifyListeners();
  }

  Future<void> editList(int id, StudentModel value) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    studentDatabase.putAt(id, value);
    getAllStudent();
    notifyListeners();
  }
}
