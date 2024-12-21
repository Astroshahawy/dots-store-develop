import 'package:flutter/material.dart';
import 'package:geeks_theme/geeks_theme.dart';
import 'package:geeks_theme/theme/extentions/extentions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/const_file.dart';
import 'color_scheme.dart';
import 'color_theme.dart';

class CustomThemeApp {
  static final GeeksTheme appTheme = GeeksTheme(
      useSeed: true,
      textTheme: (textTheme) => GoogleFonts.notoKufiArabicTextTheme(textTheme),
      lightSeedSchemeColor:
          ColorScheme.fromSeed(seedColor: lightColorScheme.primary)
              .fromColorSchemeTo(lightColorScheme),
      darkSeedSchemeColor:
          ColorScheme.fromSeed(seedColor: darkColorScheme.primary)
              .fromColorSchemeTo(darkColorScheme),
      themeChangeApp: (color) => ThemeData(
            extensions: [ColorTheme(colorScheme: color)],
            elevatedButtonTheme: _elevatedButtonTheme,
            outlinedButtonTheme: _outLinedButtonTheme,
            drawerTheme: _drawerTheme(color),
            inputDecorationTheme: _inputDecorationTheme(color),
            appBarTheme: _appBarTheme(color),
          ));
  static AppBarTheme _appBarTheme(ColorScheme color) {
    return AppBarTheme(
        backgroundColor: ElevationOverlay.colorWithOverlay(
            color.surface, color.primary, 3.0));
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme color) {
    return InputDecorationTheme(
      filled: true,
      labelStyle: TextStyle(
        color: color.onTertiary,
        fontSize: 14 /* .sp */,
      ),
      fillColor: color.onTertiary,
      hintStyle: TextStyle(
        color: color.onTertiary,
        fontSize: 14 /* .sp */,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstSizes.s40),
        borderSide: BorderSide(
          color: color.outline.withOpacity(.5),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstSizes.s40),
        borderSide: BorderSide(
          color: color.outline.withOpacity(.5),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstSizes.s40),
        borderSide: BorderSide(
          color: color.outline.withOpacity(.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstSizes.s40),
        borderSide: BorderSide(color: color.primary),
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.5,
          fontFamily: 'Shamel',
        ),
      ),
    );
  }

  static OutlinedButtonThemeData get _outLinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 2,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.5,
          fontFamily: 'Shamel',
        ),
      ),
    );
  }

  static _drawerTheme(ColorScheme color) {
    return DrawerThemeData(backgroundColor: color.background);
  }
}
