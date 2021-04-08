import 'package:flutter/material.dart';
import 'package:flutter_app/models/defaultColors.dart';
import 'package:flutter_app/pages/homePage.dart';
import 'package:flutter_app/pages/userDataPage.dart';
import 'package:flutter_app/pages/notFoundPage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: DefaultColors.primaryColor,
        accentColor: DefaultColors.secondaryColor,
        backgroundColor: DefaultColors.secondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/userData': (context) => UserDataPage(),
        '/notFound': (context) => NotFoundPage(),
      },
    );
  }
}