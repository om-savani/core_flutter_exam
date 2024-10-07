import 'package:core_flutter_exam/routes/all_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // scaffoldBackgroundColor: Color(0xffcce3de),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff7C93C3),
          // foregroundColor: Color(0xffeaf4f4),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
    );
  }
}
