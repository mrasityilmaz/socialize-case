import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTheme {
  factory AppTheme() => _instance ??= AppTheme._();

  AppTheme._();
  static AppTheme? _instance;

  static final TextStyle _k2dTextStyle = GoogleFonts.k2d();
  static final TextTheme _k2dTextTheme = GoogleFonts.k2dTextTheme().apply(displayColor: Colors.black, decorationColor: Colors.black, bodyColor: Colors.black);

  static final ColorScheme _colorSchemeLight = ColorScheme.light(primary: const Color(0xFFABABFC), secondary: Colors.grey.shade300);

  final ThemeData _themeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: _colorSchemeLight,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    fontFamily: _k2dTextStyle.fontFamily,
    textTheme: _k2dTextTheme.copyWith(),
    primaryColor: _colorSchemeLight.primary,
    buttonTheme: ButtonThemeData(
      buttonColor: _colorSchemeLight.primary,
    ),
  );

  ThemeData get themeData => _themeData;
}
