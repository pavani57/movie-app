import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_app.dart';

/// Try using const constructors as much as possible!
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
void main() async {
  /// TODO: load env file based on kReleaseMode / kProfileMode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //await dotenv.load(fileName: 'assets/.env.dev');

  runApp(const MyApp());
}
