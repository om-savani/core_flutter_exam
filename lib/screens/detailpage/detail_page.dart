import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:core_flutter_exam/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routes/all_routes.dart';
import '../../utils/globals.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name = '';
  String? grid = '';
  String? course = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(AppRoutes.homepage),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) => {(Globals.name = val)},
                        initialValue: Globals.name,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Name",
                          hintText: "John Doe",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      10.h,
                      TextFormField(
                        maxLength: 4,
                        onSaved: (val) => {(name = val)},
                        initialValue: Globals.grid,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter Grid";
                          } else if (val.length < 4) {
                            return "Grid must be 4 digits";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Grid",
                          hintText: "1234",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      10.h,
                      TextFormField(
                        onSaved: (val) => {(course = val)},
                        initialValue: Globals.course,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter course";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Course/Standard",
                          hintText: "Computer Science/12th",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      20.h,
                      ElevatedButton(
                        onPressed: () {
                          bool valid = formKey.currentState!.validate();
                          if (valid) {
                            formKey.currentState!.save();
                            Globals.students.map((e) =>
                                Globals.addStudent(name!, grid!, course!));
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 1),
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Saved Successfully',
                                message: 'Details saved successfully',
                                contentType: ContentType.success,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          } else {
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 1),
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Something went wrong !!',
                                message:
                                    'Please check your details and try again... !!',
                                contentType: ContentType.failure,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
