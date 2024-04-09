// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

enum SLStyle {
  Display_L_Regular,
  Display_M_Regular,
  Display_S_Regular,
  Heading_L_Regular,
  Heading_M_Regular,
  Heading_M_Bold,
  Heading_S_Bold,
  Heading_S_Medium,
  Heading_S_Regular,
  Text_XL_Bold,
  Text_XL_Medium,
  Text_XL_Regular,
  Text_L_Bold,
  Text_L_Medium,
  Text_L_Regular,
  Text_M_Bold,
  Text_M_Medium,
  Text_M_Regular,
  Text_S_Bold,
  Text_S_Medium,
  Text_S_Regular,
  Text_XS_Bold,
  Text_XS_Medium,
  Text_XS_Regular,
  // 나머지 스타일도 이와 같이 추가...
}

class SLTextStyle {
  // Font Sizes
  static const double _displayL = 44.0;
  static const double _displayM = 40.0;
  static const double _displayS = 36.0;
  static const double _headingL = 28.0;
  static const double _headingM = 24.0;
  static const double _headingS = 20.0;
  static const double _textXL = 20.0;
  static const double _textL = 16.0;
  static const double _textM = 14.0;
  static const double _textS = 12.0;
  static const double _textXS = 10.0;

  // Font Weights
  static const FontWeight _bold = FontWeight.w700;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _regular = FontWeight.w400;

  //Display Style
  static TextStyle? get Display_L_Regular => const TextStyle(
        fontSize: _displayL,
        fontWeight: _regular,
      );
  static TextStyle? get Display_M_Regular => const TextStyle(
        fontSize: _displayM,
        fontWeight: _regular,
      );
  static TextStyle? get Display_S_Regular => const TextStyle(
        fontSize: _displayS,
        fontWeight: _regular,
      );

  //Heading Style
  static TextStyle? get Heading_L_Regular => const TextStyle(
        fontSize: _headingL,
        fontWeight: _regular,
      );
  static TextStyle? get Heading_M_Regular => const TextStyle(
        fontSize: _headingM,
        fontWeight: _regular,
      );
  static TextStyle? get Heading_M_Bold => const TextStyle(
        fontSize: _headingM,
        fontWeight: _bold,
      );
  static TextStyle? get Heading_S_Bold => const TextStyle(
        fontSize: _headingS,
        fontWeight: _bold,
      );
  static TextStyle? get Heading_S_Meduim => const TextStyle(
        fontSize: _headingS,
        fontWeight: _medium,
      );
  static TextStyle? get Heading_S_Regular => const TextStyle(
        fontSize: _headingS,
        fontWeight: _regular,
      );

  //Text XL Style
  static TextStyle? get Text_XL_Bold => const TextStyle(
        fontSize: _textXL,
        fontWeight: _bold,
      );
  static TextStyle? get Text_XL_Medium => const TextStyle(
        fontSize: _textXL,
        fontWeight: _medium,
      );
  static TextStyle? get Text_XL_Regular => const TextStyle(
        fontSize: _textXL,
        fontWeight: _regular,
      );

  //Text L Style
  static TextStyle? get Text_L_Bold => const TextStyle(
        fontSize: _textL,
        fontWeight: _bold,
      );
  static TextStyle? get Text_L_Medium => const TextStyle(
        fontSize: _textL,
        fontWeight: _medium,
      );
  static TextStyle? get Text_L_Regular => const TextStyle(
        fontSize: _textL,
        fontWeight: _regular,
      );

  //Text M Style
  static TextStyle? get Text_M_Bold => const TextStyle(
        fontSize: _textM,
        fontWeight: _bold,
      );
  static TextStyle? get Text_M_Medium => const TextStyle(
        fontSize: _textM,
        fontWeight: _medium,
      );
  static TextStyle? get Text_M_Regular => const TextStyle(
        fontSize: _textM,
        fontWeight: _regular,
      );

  //Text S Style
  static TextStyle? get Text_S_Bold => const TextStyle(
        fontSize: _textS,
        fontWeight: _bold,
      );
  static TextStyle? get Text_S_Medium => const TextStyle(
        fontSize: _textS,
        fontWeight: _medium,
      );
  static TextStyle? get Text_S_Regular => const TextStyle(
        fontSize: _textS,
        fontWeight: _regular,
      );

  //Text XS Style
  static TextStyle? get Text_XS_Bold => const TextStyle(
        fontSize: _textXS,
        fontWeight: _bold,
      );
  static TextStyle? get Text_XS_Medium => const TextStyle(
        fontSize: _textXS,
        fontWeight: _medium,
      );
  static TextStyle? get Text_XS_Regular => const TextStyle(
        fontSize: _textXS,
        fontWeight: _regular,
      );
  final TextStyle style;
  final Color color;

  SLTextStyle({SLStyle? style, this.color = Colors.white})
      : style = _getStyle(style ?? SLStyle.Text_L_Regular);

  static TextStyle _getStyle(SLStyle style) {
    switch (style) {
      case SLStyle.Display_L_Regular:
        return Display_L_Regular!;
      case SLStyle.Display_M_Regular:
        return Display_M_Regular!;
      case SLStyle.Display_S_Regular:
        return Display_S_Regular!;
      case SLStyle.Heading_L_Regular:
        return Heading_L_Regular!;
      case SLStyle.Heading_M_Regular:
        return Heading_M_Regular!;
      case SLStyle.Heading_M_Bold:
        return Heading_M_Bold!;
      case SLStyle.Heading_S_Bold:
        return Heading_S_Bold!;
      case SLStyle.Heading_S_Medium:
        return Heading_S_Meduim!;
      case SLStyle.Heading_S_Regular:
        return Heading_S_Regular!;
      case SLStyle.Text_XL_Bold:
        return Text_XL_Bold!;
      case SLStyle.Text_XL_Medium:
        return Text_XL_Medium!;
      case SLStyle.Text_XL_Regular:
        return Text_XL_Regular!;
      case SLStyle.Text_L_Bold:
        return Text_L_Bold!;
      case SLStyle.Text_L_Medium:
        return Text_L_Medium!;
      case SLStyle.Text_L_Regular:
        return Text_L_Regular!;
      case SLStyle.Text_M_Bold:
        return Text_M_Bold!;
      case SLStyle.Text_M_Medium:
        return Text_M_Medium!;
      case SLStyle.Text_M_Regular:
        return Text_M_Regular!;
      case SLStyle.Text_S_Bold:
        return Text_S_Bold!;
      case SLStyle.Text_S_Medium:
        return Text_S_Medium!;
      case SLStyle.Text_S_Regular:
        return Text_S_Regular!;
      case SLStyle.Text_XS_Bold:
        return Text_XS_Bold!;
      case SLStyle.Text_XS_Medium:
        return Text_XS_Medium!;
      case SLStyle.Text_XS_Regular:
        return Text_XS_Regular!;
    }
  }

  TextStyle get textStyle => style.copyWith(color: color);
}

class SLColor {
  static const int _primaryColor = 0xFF0059FF;
  static const int _neutralColor = 0xFF030303;

  static const List<Color> primaryGradient = [
    Color(0xFF0059FF),
    Color(0xFF030303)
  ];

  static const List<Color> neutralGradient = [
    Color(0xFF333333),
    Color(0xFF030303)
  ];

  static const Color warning = Color(0xFFFF0000);
  static const Color success = Color(0xFF07A320);

  static const DesignMaterialColor neutral = DesignMaterialColor(
    _neutralColor,
    <int, Color>{
      5: Color(0xFFF3F3F3),
      10: Color(0xFFE6E6E6),
      20: Color(0xFFCCCCCC),
      30: Color(0xFFB3B3B3),
      40: Color(0xFF999999),
      50: Color(0xFF808080),
      60: Color(0xFF666666),
      70: Color(0xFF4C4C4C),
      80: Color(0xFF333333),
      90: Color(0xFF1A1A1A),
      100: Color(_neutralColor),
    },
  );

  static const DesignMaterialColor primary = DesignMaterialColor(
    _primaryColor,
    <int, Color>{
      5: Color(0xFFF5F8FF),
      10: Color(0xFFE5EEFF),
      20: Color(0xFFCCDEFF),
      30: Color(0xFFB2CDFF),
      40: Color(0xFF99BDFF),
      50: Color(0xFF7FACFF),
      60: Color(0xFF669BFF),
      70: Color(0xFF4C8BFF),
      80: Color(0xFF337AFF),
      90: Color(0xFF196AFF),
      100: Color(_primaryColor),
    },
  );
}

class DesignSystemColor extends ColorSwatch<String> {
  const DesignSystemColor(super.primary, super.swatch);

  Color get warning => this['warning']!;
  Color get success => this['success']!;

  // Private constructor
  // DesignSystemColor._() {
  //   warning = const Color(0xFFFF0000); // Or any color you want for warning
  //   success = const Color(0xFF07A320); // Or any color you want for success
  // }
}

class DesignMaterialColor extends ColorSwatch<int> {
  /// Creates a color swatch with a variety of shades.
  ///
  /// The `primary` argument should be the 32 bit ARGB value of one of the
  /// values in the swatch, as would be passed to the [Color.new] constructor
  /// for that same color, and as is exposed by [value]. (This is distinct from
  /// the specific index of the color in the swatch.)
  const DesignMaterialColor(super.primary, super.swatch);

  /// The lightest shade.
  Color get shade5 => this[5]!;

  /// The second lightest shade.
  Color get shade10 => this[10]!;

  /// The third lightest shade.
  Color get shade20 => this[20]!;

  /// The fourth lightest shade.
  Color get shade30 => this[30]!;

  /// The fifth lightest shade.
  Color get shade40 => this[40]!;

  /// The default shade.
  Color get shade50 => this[50]!;

  /// The fourth darkest shade.
  Color get shade60 => this[60]!;

  /// The third darkest shade.
  Color get shade70 => this[70]!;

  /// The second darkest shade.
  Color get shade80 => this[80]!;

  /// The darkest shade.
  Color get shade90 => this[90]!;
}
