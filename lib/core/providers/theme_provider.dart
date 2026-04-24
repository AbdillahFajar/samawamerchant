import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier { //Pakai ChangeNotifier untuk proses rebuild tema
  bool _isDark = false; // state: mode dark di-set ke false, karena mode utamanya adalah light

  // Getter
  bool get isDark => _isDark;

  // Menghasilkan ThemeMode yang akan dibaca MaterialApp.
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  // Kutukan pembalik, untuk membalikkan kondisi dari light ke dark atau sebaliknya
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners(); //Pemicu untuk memberi tahu widget yang mendengarkan perubahan state ini agar rebuild dengan theme baru
  }

  /**Tentang ThemeMode:
   ThemeMode adalah enum yang digunakan untuk menentukan mode tema yang akan digunakan oleh aplikasi. Ada tiga nilai dalam ThemeMode:
   - ThemeMode.system, tema mengikuti pengaturan sistem atau device,
   - ThemeMode.light, memaksa tema ke mode terang, dan
   - ThemeMode.dart, memaksa tema ke mode gelap.
   **/
}