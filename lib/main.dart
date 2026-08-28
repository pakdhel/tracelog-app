import 'package:flutter/material.dart';
import 'package:tracelog_app/screens/home_screen.dart';
import 'package:tracelog_app/style/theme/tracelog_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TracelogTheme.lightTheme,
      home: HomeScreen()
    );
  }
}
