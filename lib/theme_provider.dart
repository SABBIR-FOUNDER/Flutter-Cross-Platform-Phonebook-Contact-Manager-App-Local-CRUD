import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode {
    return _isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> loadTheme() async {
    final preferences =
    await SharedPreferences.getInstance();

    _isDarkMode =
        preferences.getBool('isDarkMode') ?? false;

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;

    final preferences =
    await SharedPreferences.getInstance();

    await preferences.setBool(
      'isDarkMode',
      value,
    );

    notifyListeners();
  }
}