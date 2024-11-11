
import 'package:flutter/material.dart';

import '../bloc_wrapper.dart';
import '../screens/home.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const splash = '/splash';
  static const home ='/home';

  static Route<dynamic> userRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
