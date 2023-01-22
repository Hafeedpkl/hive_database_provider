import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/core/constants.dart';
import 'package:student_details/controller/provider/student_provider.dart';
import 'package:student_details/db/functions/db_functions.dart';
import 'package:student_details/db/model/data_model.dart';
import 'package:student_details/screens/StudentDetails/student_details.dart';

class ListStudentWidget extends StatelessWidget {
  ListStudentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final data = context.watch<StudentProvider>().name;
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              kHieght10,
              CupertinoSearchTextField(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.close),
                backgroundColor: Colors.white,
              ),
              kHieght10,
              Text(data),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = studentList[index];
                    return Card(
                      elevation: 4,
                      color: Colors.purple.shade100,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(
                            File(data.photo),
                          ),
                        ),
                        title: Text(data.name),
                        subtitle: Text('${data.age} years old'),
                        trailing: IconButton(
                          onPressed: () {
                            deleteStudent(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetails(
                                name: data.name,
                                age: data.age,
                                mobile: data.mobile,
                                school: data.school,
                                index: index,
                                photo: data.photo,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: studentList.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
