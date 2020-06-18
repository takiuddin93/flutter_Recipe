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
      // home: Dashboard(
      //   title: "Login",
      //   token:
      //       "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3JjYXBwLnV0ZWNoLmRldi9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTU5MjQ4OTEyMiwiZXhwIjoxNTkyNDkyNzIyLCJuYmYiOjE1OTI0ODkxMjIsImp0aSI6IkR6cFJZZUM0ZnpodWtWUEkiLCJzdWIiOjEsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.xpngvM2dv-r99gkXS4O4HtRR__98yQI3_9BFCkhV0yo",
      // ),
    );
  }
}
