import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/core/constants.dart';
import 'package:student_details/controller/provider/student_provider.dart';
import 'package:student_details/screens/StudentDetails/student_details.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          kHieght10,
          CupertinoSearchTextField(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.close),
            backgroundColor: Colors.white,
            onChanged: (value) {
              Provider.of<StudentProvider>(context, listen: false)
                  .runFilter(value);
            },
          ),
          kHieght10,
          Expanded(
            child: Consumer<StudentProvider>(
                builder: (BuildContext ctx, value, Widget? child) {
              if (value.foundUsers.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = value.foundUsers[index];
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
                            StudentProvider.deleteItem(
                              context,
                              data.id.toString(),
                            );
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
                  itemCount: value.foundUsers.length,
                );
              } else {
                return const Center(
                  child: Text(
                    'Add some students',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
