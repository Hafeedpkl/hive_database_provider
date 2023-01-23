import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/provider/student_provider.dart';
import 'package:student_details/screens/AddStudent/add_student_widget.dart';
import 'package:student_details/screens/home/widgets/list_student_widget.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.getAllStudents();
    });
    return Scaffold(
      backgroundColor: Colors.pinkAccent.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: const SafeArea(
        child: ListStudentWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddStudentWidget(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
