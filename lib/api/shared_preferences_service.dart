import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _themeKey = "MY_THEME";

  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString == null) {
      return ThemeMode.system;
    } else {
      return ThemeMode.values.firstWhere((mode) => mode.name == themeString);
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      theme.name,
    ); // return 'dark', 'light', 'system'
  }

  static const String _autoTrackKey = "AUTO_TRACK";

  Future<bool> getAutoTrack() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoTrackKey) ?? false;
  }

  Future<void> setAutoTrack(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoTrackKey, isEnabled);
  }
}
