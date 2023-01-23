import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/db/functions/db_functions.dart';
import 'package:student_details/screens/home/screen_home.dart';

import '../../db/model/data_model.dart';

// ignore: must_be_immutable
class EditStudent extends StatelessWidget {
  final String name;
  final String age;
  final String mobile;
  final String school;
  final String image;
  final int index;
  final String id;

  EditStudent(
      {super.key,
      required this.name,
      required this.age,
      required this.mobile,
      required this.school,
      required this.index,
      required this.image,
      required this.id});

  TextEditingController _nameController = TextEditingController();

  TextEditingController _ageController = TextEditingController();

  TextEditingController _mobileController = TextEditingController();

  TextEditingController _schoolController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: name);
    _ageController = TextEditingController(text: age);
    _mobileController = TextEditingController(text: mobile);
    _schoolController = TextEditingController(text: school);
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
              child: Column(
                children: [
                  const Text(
                    'Edit Student Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(
                      File(image),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          if (_formKey.currentState!.validate()) {
                            onEditSaveButton(context);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onEditSaveButton(ctx) async {
    final studentmodel = StudentModel(
      name: _nameController.text,
      age: _ageController.text,
      mobile: _mobileController.text,
      school: _schoolController.text,
      photo: image.toString(),
      id: id,
    );
    Provider.of<FunctionDB>(ctx, listen: false).editList(index, studentmodel);

    Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => const ScreenHome(),
        ));
  }
}
