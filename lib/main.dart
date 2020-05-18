import 'package:flutter/material.dart';
import 'package:sharedpreferencelogin/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up with Flutter',
      home: new MyCustomForm());
  }
}