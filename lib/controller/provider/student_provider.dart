import 'package:flutter/cupertino.dart';
import 'package:student_details/db/model/data_model.dart';

class StudentProvider with ChangeNotifier {
  String name = 'hafeed';
 final List<StudentModel> studentList = studentDB
  void runFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if(enteredKeyword.isEmpty){
      results = stu
    }
  }
}
