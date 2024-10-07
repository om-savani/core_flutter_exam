import 'package:core_flutter_exam/routes/all_routes.dart';
import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: Globals.students
                .map(
                  (e) => ListTile(
                    leading: Text(e['grid']),
                    title: Text(
                      e['name'],
                    ),
                    subtitle: Text(
                      e['grid'],
                    ),
                    trailing: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showAboutDialog(context: context);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              Globals.students.remove(e);
                            });
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.detailpage);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.detailpage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
