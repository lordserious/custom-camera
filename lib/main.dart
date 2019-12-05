import 'package:flutter/material.dart';
// import 'page/test_page.dart';
import 'page/animations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: TestPage(
      )
    );
  }
}
