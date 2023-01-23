import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_details/db/functions/db_functions.dart';
import 'package:student_details/db/model/data_model.dart';

class StudentProvider with ChangeNotifier {
  final List<StudentModel> studentList = FunctionDB.studentList;

  File? sphoto;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      sphoto = photoTemp;
    }
    notifyListeners();
  }

  List<StudentModel> foundUsers = [];

  Future<void> getAllStudents() async {
    final students = await FunctionDB().getAllStudent();
    foundUsers = students;
    if (foundUsers.isNotEmpty) {
      log('founduser have data');
    }
    notifyListeners();
  }

  void addStudent(data) {
    foundUsers.clear();
    foundUsers.addAll(data);
    notifyListeners();
  }

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

  static deleteItem(BuildContext context, String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure want to delete this ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Provider.of<FunctionDB>(context, listen: false)
                      .deleteStudent(id);
                  Provider.of<StudentProvider>(context, listen: false)
                      .getAllStudents();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Successfully deleted'),
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
          ],
        );
      },
    );
  }
}
