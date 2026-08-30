import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/providers/providers.dart';

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final sharedPreferences = ref.read(sharePreferencesServiceProvider);
    final mode = await sharedPreferences.getTheme();
    return mode;
  }

  void toggleTheme() async {
    final currentTheme = state.value;
    final sharedPrefs = ref.read(sharePreferencesServiceProvider);
    ThemeMode? newTheme;
    if (currentTheme != null) {
      if (currentTheme == ThemeMode.dark) {
        newTheme = ThemeMode.light;
      } else if (currentTheme == ThemeMode.light) {
        newTheme = ThemeMode.dark;
      } else {
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;

        newTheme = brightness == Brightness.dark
            ? ThemeMode.light
            : ThemeMode.dark;
      }

      await sharedPrefs.setTheme(newTheme);
      state = AsyncValue.data(newTheme);
    }
  }
}

final themeProvider = AsyncNotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
