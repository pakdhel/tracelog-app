import 'package:flutter/material.dart';
import 'package:tracelog_app/background_service.dart';
import 'package:tracelog_app/providers/theme_provider.dart';
import 'package:tracelog_app/screens/home_screen.dart';
import 'package:tracelog_app/style/theme/tracelog_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      theme: TracelogTheme.lightTheme,
      darkTheme: TracelogTheme.darkTheme,
      themeMode: theme.when(
        data: (data) => data,
        error: (error, stack) => ThemeMode.system,
        loading: () => ThemeMode.system,
      ),
      home: HomeScreen(),
    );
  }
}
