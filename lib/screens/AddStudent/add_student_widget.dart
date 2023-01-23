import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/provider/student_provider.dart';

import '../../db/functions/db_functions.dart';
import '../../db/model/data_model.dart';

// ignore: must_be_immutable
class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _schoolController = TextEditingController();

  bool imageAlert = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
      studentProvider.sphoto = null;
    }));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Consumer<StudentProvider>(builder: (context, value, _) {
                return Column(
                  children: [
                    const Text(
                      'Add Student Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    value.sphoto == null
                        ? const CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage('assets/images/d3.png'),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              File(
                                value.sphoto!.path,
                              ),
                            ),
                            radius: 60,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            studentProvider.getPhoto();
                          },
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          label: const Text('Photo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Enter Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name',
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your age',
                        labelText: 'Age',
                      ),
                      validator: (
                        value,
                      ) {
                        if (value == null || value.isEmpty) {
                          return 'Required Age ';
                        } else if (value.length > 100) {
                          return 'Enter Correct Age';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Mobile No',
                        labelText: 'Mobile No',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Phone Number';
                        } else if (value.length != 10) {
                          return 'Require valid Phone Number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _schoolController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter school name',
                        labelText: 'School',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required School Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                studentProvider.sphoto != null) {
                              onAddStudentButtonClicked(context);
                              Navigator.of(context).pop();
                            } else {
                              imageAlert = true;
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Add'),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(context) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final mobile = _mobileController.text.trim();
    final school = _schoolController.text.trim();
    if (name.isEmpty ||
        age.isEmpty ||
        mobile.isEmpty ||
        school.isEmpty ||
        Provider.of<StudentProvider>(context, listen: false)
            .sphoto!
            .path
            .isEmpty) {
      return;
    } else {
      Provider.of<StudentProvider>(context, listen: false).getAllStudents();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Student Added Successfully"),
        ),
      );
    }
    final student = StudentModel(
        name: name,
        age: age,
        mobile: mobile,
        school: school,
        photo:
            Provider.of<StudentProvider>(context, listen: false).sphoto!.path,
        id: DateTime.now().microsecondsSinceEpoch.toString());
    Provider.of<FunctionDB>(context, listen: false).addStudent(student);
    Provider.of<FunctionDB>(context, listen: false).getAllStudent();
  }
}
