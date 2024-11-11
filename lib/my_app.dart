import 'dart:async';
import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key,})
      : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOVIES APP',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.userRoutes,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
