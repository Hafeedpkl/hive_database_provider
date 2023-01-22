import 'package:flutter/material.dart';
import 'package:student_details/screens/home/widgets/add_student_widget.dart';
import 'package:student_details/screens/home/widgets/list_student_widget.dart';

import '../../db/functions/db_functions.dart';
import 'widgets/search_student.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
      ),
      body: const SafeArea(
        child: ListStudentWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentWidget(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
