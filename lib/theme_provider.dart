import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final box = GetStorage();

  ThemeNotifier() : super(_getInitialThemeMode());

  static ThemeMode _getInitialThemeMode() {
    final box = GetStorage();
    final savedTheme = box.read('themeMode');
    if (savedTheme == 'light') {
      return ThemeMode.light;
    } else if (savedTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      // Default to system theme if no preference is saved
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    box.write('themeMode', state == ThemeMode.dark ? 'dark' : 'light');
  }
}
