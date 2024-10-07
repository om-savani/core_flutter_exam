import 'package:core_flutter_exam/routes/all_routes.dart';
import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showEditDialog(BuildContext context, int index) {
    var student = Globals.allStudents[index];
    TextEditingController nameController =
        TextEditingController(text: student['name']);
    TextEditingController idController =
        TextEditingController(text: student['id']);
    TextEditingController stdController =
        TextEditingController(text: student['std']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Student Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Student Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: "Student ID"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: stdController,
                decoration:
                    const InputDecoration(labelText: "Student Standard"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Globals.allStudents[index] = {
                    'name': nameController.text,
                    'id': idController.text,
                    'std': stdController.text,
                    'photo': student['photo'],
                  };
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Globals.allStudents.isNotEmpty
            ? ListView.builder(
                itemCount: Globals.allStudents.length,
                itemBuilder: (context, index) {
                  var student = Globals.allStudents[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   child: Image.asset(student['photo']),
                      // ),
                      title: Text(
                        student['name'] ?? "No Name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID: ${student['id'] ?? 'No ID'}"),
                          Text("Standard: ${student['std'] ?? 'No Standard'}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showEditDialog(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                Globals.allStudents.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'No student details available !!',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff4d6d),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.detailpage);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
