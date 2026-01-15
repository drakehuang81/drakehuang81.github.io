import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Terminal/Hacker-style theme for the resume website
class TerminalTheme {
  // === Colors (GitHub Dark + Starship) ===
  static const Color background = Color(0xFF0D1117);
  static const Color backgroundDark = Color(0xFF010409);

  // GitHub Colors
  static const Color gitHubText = Color(0xFFC9D1D9); // fg.default
  static const Color gitHubBlue = Color(0xFF58A6FF); // accent
  static const Color gitHubGreen = Color(0xFF3FB950); // success
  static const Color gitHubGrey = Color(0xFF8B949E); // muted
  static const Color gitHubBorder = Color(0xFF30363D); // border

  // Starship Colors
  static const Color starshipCyan = Color(
    0xFF79C0FF,
  ); // Close to cyan, slightly blueish fits GitHub
  static const Color starshipPurple = Color(0xFFBC8CFF); // Purple
  static const Color starshipRed = Color(0xFFFF7B72); // Red

  // Legacy/Effect Colors
  static const Color terminalGreen = gitHubGreen;
  static const Color terminalGreenBright = Color(0xFF4ADE80);
  static const Color terminalGreenMuted = gitHubGrey;
  static const Color cursorColor = gitHubGreen;
  static const Color inputBackground = Color(
    0x1A58A6FF,
  ); // Blueish tint for input
  static const Color borderColor = gitHubBorder;

  // === Text Styles ===
  static TextStyle get titleLarge => GoogleFonts.firaCode(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: gitHubText, // White/Grey
    height: 1.2,
  );

  static TextStyle get titleMedium => GoogleFonts.firaCode(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: gitHubText,
  );

  static TextStyle get titleSmall => GoogleFonts.firaCode(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: gitHubBlue, // Blue accent for subtitles
  );

  static TextStyle get bodyLarge => GoogleFonts.firaCode(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: gitHubText, // Main text
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: gitHubText,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.firaCode(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: gitHubGrey,
  );

  static TextStyle get commandPrompt => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: gitHubText,
  );

  // Special styles for prompt parts
  static TextStyle get promptPath => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: starshipCyan,
  );

  static TextStyle get promptSymbol => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: gitHubGreen,
  );

  static TextStyle get navItem => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: gitHubText,
  );

  static TextStyle get navItemSelected => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: gitHubBlue, // Active item Blue
  );

  static TextStyle get inputLabel => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: gitHubBlue,
  );

  static TextStyle get buttonText => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: gitHubText,
  );

  // === Decorations ===
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: background,
    border: Border.all(color: borderColor, width: 1),
    borderRadius: BorderRadius.circular(6),
    boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10)],
  );

  static BoxDecoration get avatarDecoration => BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: gitHubGrey, width: 2), // Subtle border
    boxShadow: [
      BoxShadow(
        color: gitHubBlue.withAlpha(30), // Blue glow
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
  );

  static InputDecoration terminalInputDecoration(String label) {
    return InputDecoration(
      prefixText: '$label > ',
      prefixStyle: inputLabel,
      filled: true,
      fillColor: Color(0xFF161B22), // GitHub Input bg
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: gitHubBlue, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  // === Theme Data ===
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: gitHubBlue,
    colorScheme: const ColorScheme.dark(
      primary: gitHubBlue,
      secondary: gitHubGreen,
      surface: background,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: gitHubText,
      outline: borderColor,
    ),
    textTheme: TextTheme(
      displayLarge: titleLarge,
      displayMedium: titleMedium,
      titleLarge: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF161B22),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: gitHubBlue, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      labelStyle: inputLabel,
      hintStyle: bodySmall,
    ),
  );
}
