import 'package:fllutter/screens/libraryScreen.dart';
import 'package:fllutter/screens/loginScreen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LibraryScreen(), 
        // '/library':(context)=>LibraryScreen()
      },
    );
  }
}
