import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/screens/login.dart';
import 'package:recipe/utils/universal_variables.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: UniversalVariables.primaryDodgerBlue));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(
        title: "Login",
      ),
    );
  }
}
