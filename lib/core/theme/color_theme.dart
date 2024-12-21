import 'package:flutter/material.dart';

@immutable
class ColorTheme extends ThemeExtension<ColorTheme> {
  const ColorTheme({
    
    required this.colorScheme,

  });


  final ColorScheme colorScheme;
  @override
  ColorTheme copyWith({

    ColorScheme? colorScheme,
  }) {
    return ColorTheme(

      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  ColorTheme lerp(ThemeExtension<ColorTheme>? other, double t) {
    if (other is! ColorTheme) {
      return this;
    }
    return ColorTheme(

      colorScheme: ColorScheme.lerp(colorScheme, other.colorScheme, t),

    );
  }


}
