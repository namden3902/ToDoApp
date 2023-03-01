import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_by_dn/dif/local.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'system';
  String currentLangugae = 'VNE';

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }

  changeLanguage(String lang) async {
    final SharedPreferences _lang = await SharedPreferences.getInstance();
    await _lang.setString('lang', lang);
    currentLangugae = lang;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences _lang = await SharedPreferences.getInstance();
    currentTheme = _prefs.getString('theme') ?? 'system';
    currentLangugae = _lang.getString('lang') ?? 'VNE';
    notifyListeners();
  }
}
