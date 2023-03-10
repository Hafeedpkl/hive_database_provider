// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:student_details/db/functions/db_functions.dart';
// import 'package:student_details/screens/StudentDetails/student_details.dart';

// import '../../db/model/data_model.dart';

// class Search extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return <Widget>[
//       IconButton(
//         onPressed: () {
//           query = "";
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, query);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: studentListNotifier,
//       builder:
//           (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
//         return ListView.builder(
//           itemBuilder: (ctx, index) {
//             final data = studentList[index];
//             if (data.name.toLowerCase().contains(query.toLowerCase())) {
//               return Column(
//                 children: [
//                   Card(
//                     color: Colors.blue[100],
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 30,
//                         backgroundImage: FileImage(
//                           File(data.photo),
//                         ),
//                       ),
//                       title: Text(data.name),
//                       subtitle: Text('${data.age} years old'),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => StudentDetails(
//                               name: data.name,
//                               age: data.age,
//                               mobile: data.mobile,
//                               school: data.school,
//                               index: index,
//                               photo: data.photo,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const Divider(),
//                 ],
//               );
//             } else {
//               return Container();
//             }
//           },
//           itemCount: studentList.length,
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: studentListNotifier,
//       builder:
//           (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
//         return ListView.builder(
//           itemBuilder: (ctx, index) {
//             final data = studentList[index];
//             if (data.name.toLowerCase().contains(query.toLowerCase())) {
//               return Column(
//                 children: [
//                   ListTile(
//                     onTap: () {
//                       Navigator.of(ctx).push(
//                         MaterialPageRoute(
//                           builder: (context) => StudentDetails(
//                             age: data.age,
//                             index: index,
//                             name: data.name,
//                             mobile: data.mobile,
//                             photo: data.photo,
//                             school: data.school,
//                           ),
//                         ),
//                       );
//                     },
//                     title: Text(data.name),
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundImage: FileImage(File(data.photo)),
//                     ),
//                   ),
//                   const Divider(),
//                 ],
//               );
//             } else {
//               return Container();
//             }
//           },
//           itemCount: studentList.length,
//         );
//       },
//     );
//   }
// }
