//Implementasi pewarnaa yang telah dibuat di app_colors.dart
import "package:flutter/material.dart";
import "../constants/app_colors.dart";

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primaryLight,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
        brightness: Brightness.light,
        error: AppColors.error,
      ),
      unselectedWidgetColor: AppColors.darkSurface,
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.lightTextPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        hintStyle: TextStyle(color: AppColors.lightTextHint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightBorder, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      //Bikin tombol switch ke light mode
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(Icons.dark_mode, size: 16, color: Colors.amber); //saat ON, ikon mode gelap muncul
          }
          return const Icon(Icons.dark_mode, size: 16, color: Colors.amber); //saat OFF, ikon mode terang muncul
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight; //saat ON, warna hijau muda muncul
          }
        return AppColors.primaryDark; //saat OFF, warna abu-abu
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withValues(alpha: 0.4); //saat ON, warna hijau gelap dan sedikit transaparan muncul
          }
        return Colors.grey.shade300;
        }),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primaryDark,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        brightness: Brightness.dark,
        error: AppColors.error,
      ),
      unselectedWidgetColor: AppColors.lightSurface,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.darkTextPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceCard,
        hintStyle: TextStyle(color: AppColors.darkTextHint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkBorder, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      //Bikin tombol switch ke dark mode
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(Icons.light_mode, size: 16, color: Colors.white); //saat ON, ikon mode gelap muncul
          }
          return const Icon(Icons.light_mode, size: 16, color: Colors.white); //saat OFF, ikon mode terang muncul
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkSurface; //saat ON, warna hijau gelap muncul
          }
        return Colors.grey.shade400; //saat OFF, warna abu-abu
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkSurface.withValues(alpha: 0.4); //saat ON, warna hijau sedikit gelap dan sedikit transparan muncul
          }
        return Colors.grey.shade300;
        }),
      ),

      //Theme untuk text di dark mode. TextTheme ini hanya dipasang di dark mode, karena di light mode, warna text sudah otomatis hitam
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
        bodySmall: TextStyle(color: AppColors.darkTextSecondary),
        titleLarge: TextStyle(color: AppColors.darkTextPrimary),
        titleMedium: TextStyle(color: AppColors.darkTextPrimary),
      )
    );
  }
}
