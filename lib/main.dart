import 'package:flutter/material.dart';
import 'package:tracelog_app/screens/home_screen.dart';
import 'package:tracelog_app/style/theme/tracelog_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: TracelogTheme.lightTheme, home: HomeScreen());
  }
}
