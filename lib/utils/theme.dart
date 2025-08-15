// import 'package:flutter/material.dart';

// class AppTheme {
//   // Light Theme
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//     scaffoldBackgroundColor: Colors.white,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: Colors.black87,
//       ),
//       iconTheme: IconThemeData(color: Colors.black87),
//     ),
//     textTheme: const TextTheme(
//       titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//       bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
//       bodySmall: TextStyle(fontSize: 14, color: Colors.black54),
//     ),
//     cardTheme: CardThemeData(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       margin: const EdgeInsets.all(8),
//     ),
//   );

//   // Dark Theme
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: Colors.blueGrey,
//       brightness: Brightness.dark,
//     ),
//     scaffoldBackgroundColor: const Color(0xFF121212),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       iconTheme: IconThemeData(color: Colors.white),
//     ),
//     textTheme: const TextTheme(
//       titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//       bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
//       bodySmall: TextStyle(fontSize: 14, color: Colors.white70),
//     ),
//     cardTheme: CardThemeData(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       margin: const EdgeInsets.all(8),
//       color: const Color(0xFF1E1E1E),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
      bodySmall: GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.all(8),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.white),
      bodySmall: GoogleFonts.roboto(fontSize: 14, color: Colors.white70),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      color: const Color(0xFF1E1E1E),
    ),
  );
}
