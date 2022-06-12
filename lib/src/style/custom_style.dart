import 'package:flutter/material.dart';

class CustomStyle {
  static const Color secondaryColor = Color(0xff3F3D56);

  //Auto generated primary color
  static const MaterialColor primarycolor =
      MaterialColor(_primarycolorPrimaryValue, <int, Color>{
    50: Color(0xFFEDECFF),
    100: Color(0xFFD3D0FF),
    200: Color(0xFFB6B1FF),
    300: Color(0xFF9892FF),
    400: Color(0xFF827AFF),
    500: Color(_primarycolorPrimaryValue),
    600: Color(0xFF645BFF),
    700: Color(0xFF5951FF),
    800: Color(0xFF4F47FF),
    900: Color(0xFF3D35FF),
  });
  static const int _primarycolorPrimaryValue = 0xFF6C63FF;

  static const MaterialColor primarycolorAccent =
      MaterialColor(_primarycolorAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_primarycolorAccentValue),
    400: Color(0xFFE0DFFF),
    700: Color(0xFFC8C6FF),
  });
  static const int _primarycolorAccentValue = 0xFFFFFFFF;

  static const double _titleSize = 32;
  static const double _title2Size = 24;
  static const double _contentSize = 18;
  static const double _content2Size = 14;
  static const double _content3Size = 12;

  static TextStyle getStyle(
      Color color, FontSizeEnum fontSizeEnum, FontWeight fontWeight) {
    return TextStyle(
        color: color,
        fontSize: CustomStyle._getFont(fontSizeEnum),
        fontWeight: fontWeight);
  }

  static double _getFont(FontSizeEnum fontSizeEnum) {
    switch (fontSizeEnum) {
      case FontSizeEnum.title:
        return _titleSize;
      case FontSizeEnum.title2:
        return _title2Size;
      case FontSizeEnum.content:
        return _contentSize;
      case FontSizeEnum.content2:
        return _content2Size;
      case FontSizeEnum.content3:
        return _content3Size;
      default:
        return _contentSize;
    }
  }
}

enum FontSizeEnum { title, title2, content, content2, content3 }
