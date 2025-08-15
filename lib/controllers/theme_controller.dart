import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  var themeMode = ThemeMode.system.obs;

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    String? storedTheme = _storage.read('themeMode');
    if (storedTheme != null) {
      themeMode.value = storedTheme == 'dark'
          ? ThemeMode.dark
          : ThemeMode.light;
    }
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
      _storage.write('themeMode', 'light');
    } else {
      themeMode.value = ThemeMode.dark;
      _storage.write('themeMode', 'dark');
    }
  }
}
