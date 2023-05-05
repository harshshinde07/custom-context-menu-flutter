import 'package:flutter/material.dart';
import 'package:custom_context_menu/custom_context_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Context Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomContextMenuPage(),
    );
  }
}
