import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  bool isDarkMode = false;

  ThemeNotifier() {
    loadThemePreference();
  }

  ThemeData get themeData => isDarkMode ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    notifyListeners();
    saveThemePreference();
  }

  void loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool("IsDarkTheme") ?? false;
    notifyListeners();
  }

  void saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsDarkTheme", isDarkMode);
  }
}
