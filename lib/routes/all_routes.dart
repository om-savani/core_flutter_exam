import 'package:core_flutter_exam/screens/detailpage/detail_page.dart';
import 'package:flutter/material.dart';

import '../screens/homepage/homepage.dart';

class AppRoutes {
  // static String splashscreen = "/";
  static String homepage = "/";
  static String detailpage = "DetailPage";

  static Map<String, Widget Function(BuildContext)> routes = {
    // splashscreen: (context) => SplashScreen(),
    homepage: (context) => const Homepage(),
    detailpage: (context) => const DetailPage(),
  };
}
