import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/all_routes.dart';
import '../../utils/globals.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Map<String, dynamic>> studentControllers = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (Globals.allStudents.isEmpty) {
      studentControllers = [
        {
          "name": TextEditingController(),
          "id": TextEditingController(),
          "std": TextEditingController(),
          "photo": null,
        }
      ];
    } else {
      for (var student in Globals.allStudents) {
        studentControllers.add({
          "name": TextEditingController(text: student["name"]),
          "id": TextEditingController(text: student["id"]),
          "std": TextEditingController(text: student["std"]),
          "photo": student["photo"],
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controllers in studentControllers) {
      controllers["name"]!.dispose();
      controllers["id"]!.dispose();
      controllers["std"]!.dispose();
    }
  }

  void saveStudentDetails() {
    Globals.allStudents.clear();
    for (var controllers in studentControllers) {
      if (controllers["name"]!.text.isNotEmpty &&
          controllers["id"]!.text.isNotEmpty &&
          controllers["std"]!.text.isNotEmpty) {
        Globals.allStudents.add({
          "name": controllers["name"]!.text,
          "id": controllers["id"]!.text,
          "std": controllers["std"]!.text,
          "photo": controllers["photo"], // Store student photo
        });
      }
    }
  }

  Future<void> pickImage(int index) async {
    final ImagePicker imagePicker = ImagePicker();
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Image Source"),
          actions: <Widget>[
            ElevatedButton(
              child: const Icon(CupertinoIcons.camera, size: 30),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
            ),
            ElevatedButton(
              child: const Icon(CupertinoIcons.photo, size: 30),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? file = await imagePicker.pickImage(source: source);
      if (file != null) {
        setState(() {
          studentControllers[index]["photo"] =
              File(file.path); // Update student image
        });
      }
    }
  }

  Widget customButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xffff4d6d),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(AppRoutes.homepage);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            "Student Details",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    "Enter student details",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(
                        studentControllers.length,
                        (index) => Column(
                          children: [
                            // Image Picker for each student
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    foregroundImage: studentControllers[index]
                                                ["photo"] !=
                                            null
                                        ? FileImage(
                                            studentControllers[index]["photo"]!)
                                        : null,
                                    child: const Text("Add Photo"),
                                    radius: 70,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                  FloatingActionButton.small(
                                    onPressed: () => pickImage(index),
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: studentControllers[index]["name"],
                              decoration: const InputDecoration(
                                labelText: 'Student Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please enter the student name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter the GRID";
                                } else if (val.length < 4) {
                                  return "GRID must be 4 digits";
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              controller: studentControllers[index]["id"],
                              decoration: const InputDecoration(
                                labelText: 'GRID',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: studentControllers[index]["std"],
                              decoration: const InputDecoration(
                                labelText: 'Course/Standard',
                                border: OutlineInputBorder(),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please enter the student standard';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  studentControllers.removeAt(index);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  customButton("Add", () {
                    studentControllers.add({
                      "name": TextEditingController(),
                      "id": TextEditingController(),
                      "std": TextEditingController(),
                      "photo": null, // Add space for student photo
                    });
                    setState(() {});
                  }),
                  const SizedBox(height: 20),
                  customButton("Save", () {
                    if (formKey.currentState!.validate()) {
                      saveStudentDetails();
                      Navigator.of(context).pop(AppRoutes.homepage);
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
