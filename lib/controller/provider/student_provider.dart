import 'package:flutter/cupertino.dart';
import 'package:student_details/db/functions/db_functions.dart';
import 'package:student_details/db/model/data_model.dart';

class StudentProvider with ChangeNotifier {
  String name = 'hafeed';
  final List<StudentModel> studentList = FunctionDB.studentList;
  List<StudentModel> foundUsers = [];
  void runFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = studentList;
    } else {
      results = studentList
          .where((element) =>
              element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    foundUsers = results;
    notifyListeners();
  }
}
