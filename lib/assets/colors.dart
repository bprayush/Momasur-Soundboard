import 'package:flutter/widgets.dart';

class AppColors {
  static const LIGHT_GREEN = Color(0xff81ecec);
  static const LIGHT_BLUE = Color(0xffa29bfe);
  static const WHITISH_GREY = Color(0xff636e72);
  static const DARK_GREEN = Color(0xff00b894);
  static const DARK_BLUE = Color(0xff0984e3);
  static const LIGHT_PURPLE = Color(0xffa29bfe);
  static const DARK_PURPLE = Color(0xff6c5ce7);

  static List<Color> colorsList = [
    LIGHT_BLUE,
    LIGHT_GREEN,
    WHITISH_GREY,
    DARK_GREEN,
    DARK_BLUE,
    LIGHT_PURPLE,
    DARK_PURPLE,
  ];

  static Color get randomColor {
    colorsList.shuffle();
    return colorsList[0];
  }
}
